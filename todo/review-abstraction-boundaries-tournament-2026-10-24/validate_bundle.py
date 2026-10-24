"""Read-only static validation; does not dispatch agents or execute product code."""
from pathlib import Path
import csv
import hashlib
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parent
manifest = json.loads((ROOT / 'manifest.json').read_text(encoding='utf-8'))
core = (ROOT / 'design/common-core.md').read_text(encoding='utf-8')
skill_name = manifest['skill_name']
checks = []

def check(condition, description):
    if not condition:
        raise AssertionError(description)
    checks.append(description)

check(len(manifest['candidates']) == 8, 'Eight full candidates registered')
check(len({c['id'] for c in manifest['candidates']}) == 8, 'Candidate IDs unique')
check(manifest['evaluation_block'] == {'batches_per_candidate':2,'reviewers_per_batch':3,'valid_runs_per_candidate_per_pass':6}, 'Every comparison pass uses 2x3 per candidate')
check(manifest['maximum_passes_per_encounter'] == 3, 'Repeat cap fixed before execution')
check(manifest['scoring']['utility_affects_advancement'] is False, 'Positive utility cannot offset negatives or break ties')
check(manifest['reviewer']['native_ui_subagents_only'] is True, 'No silent CLI fallback')

approaches = set()
for item in manifest['candidates']:
    path = ROOT / item['skill_path']
    raw = path.read_bytes()
    text = raw.decode('utf-8').replace('\r\n', '\n')
    check(hashlib.sha256(raw).hexdigest().upper() == item['sha256'], f"{item['id']}: immutable file hash matches")
    match = re.match(r'\A---\n(.*?)\n---\n', text, re.S)
    check(match is not None, f"{item['id']}: frontmatter present")
    metadata = dict(line.split(': ', 1) for line in match[1].splitlines())
    check(set(metadata) == {'name','description'}, f"{item['id']}: no unexpected metadata")
    check(metadata['name'] == skill_name == path.parent.name and len(skill_name) <= 64, f"{item['id']}: package name aligned")
    description = metadata['description']
    check(description.startswith('Use for a read-only review when ') and len(description) <= 1024 and '<' not in description and '>' not in description, f"{item['id']}: trigger and description valid")
    for heading in ['## Activation and Working Mode','## Focus','## Guiding Principles','## Procedure','## Rules Against Misjudgment','## Evidence and Recommendations','## Output']:
        check(text.count(heading) == 1, f"{item['id']}: {heading} coherent")
    check('Do not modify files or produce patches.' in text and 'Do not execute project code, builds, tests, or generators.' in text, f"{item['id']}: read-only constraints preserved")
    check('| Maturity |' in text and 'There is no finding quota and no architecture score.' in text, f"{item['id']}: common output safeguards preserved")
    check(re.search(r'\b(Hullmark|BasicRTS|Unity|T01|V0[1-8]|gpt-6-luna|tournament)\b|bca95497|c638213', text, re.I) is None, f"{item['id']}: no experiment or product leakage")
    if item['kind'] == 'historical-control':
        repo = Path(manifest['canonical_experiment_path']).parents[1]
        original = subprocess.check_output(['git','-C',str(repo),'show',f"{item['source_commit']}:.agents/skills/{skill_name}/SKILL.md"])
        check(raw == original, f"{item['id']}: exact historical control blob preserved")
    else:
        approach = re.search(r'## Review Approach\n\n(.*?)\n\n(?=## Procedure)', text, re.S)
        check(approach is not None, f"{item['id']}: explicit review approach present")
        check(approach[1] not in approaches, f"{item['id']}: distinct review approach")
        approaches.add(approach[1])
        stripped = text[:approach.start()] + text[approach.end():]
        check(stripped.rstrip() == core.rstrip(), f"{item['id']}: only approach differs from shared core")

for path in ROOT.rglob('*.md'):
    if 'candidates' in path.parts:
        continue
    text = path.read_text(encoding='utf-8')
    for target in re.findall(r'\]\(([^)]+)\)', text):
        if '://' in target or target.startswith('#'):
            continue
        check((path.parent / target.split('#')[0]).exists(), f'{path.relative_to(ROOT)}: link {target} resolves')

with (ROOT / 'results/matches.csv').open(encoding='utf-8', newline='') as stream:
    matches = list(csv.DictReader(stream))
check([m['match_id'] for m in matches] == ['Q01','Q02','Q03','Q04','S01','S02','F01'], 'Seven bracket nodes registered')
check(sorted([m[k] for m in matches[:4] for k in ['input_a','input_b']]) == [f'V{i:02d}' for i in range(1,9)], 'Each candidate appears once in the quarterfinals')
check(all(m['status'] == 'PENDING' for m in matches), 'No invented match result')
for name in ['runs.csv','findings.csv','scores.csv']:
    with (ROOT / 'results' / name).open(encoding='utf-8', newline='') as stream:
        check(list(csv.DictReader(stream)) == [], f'{name}: no fabricated run or assessment')

plan = (ROOT / 'TESTPLAN.md').read_text(encoding='utf-8')
check(all(f'**{n} Läufe**' in plan for n in [84,252,432]), 'Minimum and bounded maximum run counts documented')
check('PREPARED_NOT_STARTED' in (ROOT / 'results/TOURNAMENT.md').read_text(encoding='utf-8'), 'Tournament has not started')
print(json.dumps({'result':'PASS','checks':len(checks),'candidates':8,'reviewer_runs':0,'warnings':0}, ensure_ascii=False))
