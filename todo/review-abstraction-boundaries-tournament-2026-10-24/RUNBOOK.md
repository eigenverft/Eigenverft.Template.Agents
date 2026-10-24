# Ausführung und Dokumentation

## Vor dem ersten Lauf

1. Plan, Rubrik, Prompts, Fixture und alle acht Kandidaten vollständig prüfen,
   statisch validieren, committen und pushen. Den Commit im Ereignisprotokoll
   notieren; er ist der Freeze-Punkt vor jeder Ergebniskenntnis.
2. Das Manifest gegen die Dateien prüfen. V01/V02 müssen den Originalblobs
   entsprechen; V03–V08 dürfen sich nur im Review-Approach-Abschnitt unterscheiden.
3. Verfügbarkeit frischer regulärer UI-Subagenten und des festgelegten Modells
   prüfen. Ein erfolgloser Spawn ist kein Ergebnis und kein Kandidatenfehler.
   Bei Platzmangel BLOCKED_INFRASTRUCTURE dokumentieren und keine CLI starten.
4. Das Turnier bleibt bis zur separaten Ausführung PREPARED_NOT_STARTED.
   Historische Berichte nicht ins neue Ergebnisregister übernehmen.

## Dispatch eines Blocks

1. Für Begegnung, Durchgang, Kandidat, Batch und Reviewer eine eindeutige ID
   erzeugen: `T01-Q01-P01-V01-B01-R01`. Die zweite Serie ist B02.
2. Für jeden einzelnen Lauf denselben Reviewer-Prompt rendern. Nur Skill-Pfad
   und Hash einsetzen. Produktcommit, Auftrag und Ausführungsparameter bleiben
   gleich. Prompt-SHA256 und Skill-SHA256 in runs.csv protokollieren.
3. Native Subagenten mit `model=gpt-6-luna`, `reasoning_effort=xhigh`,
   `fork_turns=none` starten; Taskname enthält die Run-ID. Agentenidentität
   sofort in runs.csv notieren, damit die UI-Aktivität nachvollziehbar bleibt.
4. Keine weiteren Prompts oder Hilfestellungen an Reviewer senden. Keine
   Reviewer-Historie wiederverwenden. Zwischenmeldungen, technische Probleme
   und Abweichungen protokollieren, aber nicht inhaltlich beantworten.
5. Erst nach Abschluss aller drei Reviewer den nächsten Batch beginnen.
   Nach sechs gültigen Läufen je Kandidat ist sein Block vollständig.

## Gültigkeit und Abbruch

Ein Lauf ist X bei falschem Modell/Skill/Hash/Quellstand, Kontextübernahme
aus anderen Reviews, Coaching, Subdelegation, anderer Review-Skill-Nutzung,
Produktmutation, Build-/Testausführung oder fehlendem bewertbarem Abschluss.
Reine technische Fehlschläge oder Verweigerungen zählen nicht als NONE.

Eine unaufgeforderte Fortschrittsmeldung ohne Bewertung oder Rückkopplung
wird als Protokollabweichung notiert; sie allein macht den Lauf nicht X.
Ein syntaktisch abweichender, aber bewertbarer Bericht bleibt gültig.
Der Nichtgebrauch eines erwarteten Findings ist kein Ungültigkeitsgrund.

X bleibt mit vollständigem Grund erhalten und wird durch einen frischen
Lauf desselben Slots ersetzt, Suffix A02 usw. Ein schwaches, aber gültiges
Ergebnis darf niemals durch Neuwürfeln ersetzt werden. Pro Slot höchstens
zwei Ersatzversuche (drei Versuche insgesamt). Danach Begegnung als
BLOCKED_INFRASTRUCTURE stoppen. Bei einer produktverändernden Ausführung
das Turnier sofort stoppen, Auswirkung klären und den Lauf nicht verwerten.
Ein Infrastrukturstopp ist kein K.O. eines Kandidaten.

## Berichte und Bewertung

- Finale Rohberichte unverändert unter results/raw/<Run-ID>.md ablegen.
  Falls eine Transportumgebung Protokolle liefert, ihre Referenz ergänzen;
  fehlende Toolprotokolle nicht erfinden oder als geprüft ausgeben.
- Neutrale Beleg-ID E0001 usw. zuordnen. Metadata mit Kandidaten-ID, Pfad,
  Hash oder Stilhinweisen für die erste Sichtung separat halten; fachlichen
  Berichtstext nicht umschreiben. Rohbericht immer erhalten.
- findings.csv pro unabhängigem Vorschlag ausfüllen; Themen über alle
  Kandidaten mit demselben Thema unter derselben Themen-ID erfassen.
- N/T/U und Quellenbegründung vor der Kandidaten-Gesamtwertung festhalten.
  Keine Bewertung allein aus Selbstbewertung oder Reifegrad übernehmen.
- Erst nach der vollständigen Auswertung scores.csv und matches.csv
  aktualisieren und den nächsten Knoten oder eine Wiederholung freigeben.

## Status und sichtbare Signale

results/TOURNAMENT.md ist die lesbare Übersicht. events.jsonl protokolliert
Zeitpunkt, Ereignis, Run-/Match-ID, Grund und Referenzen. runs.csv verfolgt
jeden Versuch, findings.csv die Belege, scores.csv die Aggregation und
matches.csv den Turnierbaum. Es werden keine hypothetischen Ergebnisse als
echte Läufe eingetragen.

Mögliche Match-Zustände: PENDING, RUNNING, ADJUDICATING, TIED_REPEAT,
ADVANCED, JOINT_ADVANCED, ELIMINATED, BLOCKED_INFRASTRUCTURE, FINAL_WINNERS.
In Übersichten die Kandidatenzustände separat ausweisen, damit ELIMINATED
nicht den ganzen Matchstatus ersetzt.

Meldung bei Weiterkommen: „V03 kommt nach Q01 weiter (N=0 gegen N=2,
je sechs gültige Läufe). Das ist ein Turnierfortschritt, keine Skill-Freigabe.“
Gleichstände und gemeinsame Sieger genauso konkret mit Laufzahl melden.
Keine Meldung „Skill erfolgreich“ wegen eines einzelnen guten Runs.

## Versionspflege

Ergebnisdaten und begründete Entscheidungen nach jeder abgeschlossenen
Begegnung in Template.Agents committen und pushen. Bei einem technischen
Stopp auch dessen reproduzierbaren Stand sichern. Alte Berichte und Urteile
erhalten; Korrekturen zusätzlich protokollieren. Keine Ergebnisse oder
Produktdetails in die Kandidaten-Skills zurückschreiben.

Hullmark behält nur die bisherige aktuelle aktive Skill-Kopie. Kandidaten
werden ausdrücklich aus ihren unveränderlichen Experimentpfaden gelesen.
Ein Turniersieg ersetzt den aktiven Skill nicht automatisch. Auswahl,
generische Gesamtprüfung und eine anschließende Aktualisierung erfolgen
als nachvollziehbarer weiterer Schritt; mehrere Sieger bleiben erhalten.
