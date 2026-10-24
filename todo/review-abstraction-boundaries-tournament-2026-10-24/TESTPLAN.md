# Testplan und Turnierregeln

## Ziel und Abgrenzung

Verglichen wird, welche Skill-Variante weniger **nachweisbar nicht tragfähige
Empfehlungen** an einen Nutzer weitergibt. Tragfähige Richtungen dürfen noch
offene Implementierungsdetails besitzen. Offene Beobachtungen und beim
Bewerten unentschiedene Fälle sind keine Fehlerpunkte.

Die Negativwertung misst nicht Vollständigkeit. Ein stiller Kandidat kann
nach dieser Regel weiterkommen; entgangene Chancen werden sichtbar notiert,
aber nicht nachträglich als Fehler gewertet. Auch ein Sieger mit null Fehlern
ist kein Nachweis vollständiger oder projektübergreifender Review-Qualität.

Diese Vorbereitung enthält keine Modellläufe. Die operative Durchführung
erfolgt erst als eigener nächster Schritt mit dem eingefrorenen Plan.

## Feste Bedingungen

- Acht Kandidaten V01–V08 gemäß Manifest; Skill-Hashes vor jedem Dispatch prüfen.
- Reviewer: GPT-6-Luna, reasoning effort `xhigh`, frischer Kontext, `fork_turns=none`.
- Ausschließlich reguläre, in der UI sichtbare Subagenten. Kein CLI-Fallback,
  keine wiederverwendeten Reviewer-Historien und keine zusätzlichen Threads.
- Pro Batch höchstens drei Reviewer gleichzeitig; zwei Batches je Kandidat
  und Begegnungsdurchgang ergeben sechs gültige Läufe.
- Gemeinsamer fester Produktcommit und gleicher Prompt; nur Skill-Pfad und
  erwarteter Hash werden pro Kandidat ersetzt.
- Kein Coaching, keine Antworten, keine Nachfragen, keine Zwischenaufträge,
  keine Kommunikation zwischen Reviewern und keine Subdelegation.
- Read-only-Quellprüfung; keine Builds, Tests, Projektcode- oder Git-Mutationen.
- Ergebnisse erst nach dem vollständigen Durchgang mit gleicher Laufzahl
  bewerten. Reviewer erhalten weder Vorbefunde noch Punkte oder Gegnerdaten.

Wenn frische native Subagenten nicht verfügbar sind, erhält das Turnier den
Status `BLOCKED_INFRASTRUCTURE`. Kandidaten bekommen dafür keine Fehler.
Ein Wechsel des Modells, der Laufumgebung oder des Produktstands startet
eine neue Vergleichsserie und wird nicht mit den alten Werten verrechnet.

## Grundeinheit einer Begegnung

Ein Durchgang P01 ist **Kandidat A: 2×3 gegen Kandidat B: 2×3**, also zwölf
gültige Reviewer-Läufe. Ein einzelner guter Lauf oder ein einzelner Batch
entscheidet keine Begegnung. Gleichstände werden ausschließlich mit frischen
vollständigen 2×3-Blöcken je verbleibendem Kandidaten wiederholt.

Die Reihenfolge ist in P01 A-B-B-A auf Batch-Ebene: A/B01, B/B01, B/B02,
A/B02. In P02 wird sie umgekehrt; P03 nutzt wieder die erste Reihenfolge.
Kein Batch beginnt, bevor der vorherige mit drei finalen Ergebnissen oder
protokolliertem technischen Abbruch abgeschlossen ist. So laufen nie mehr
als drei Reviewer gleichzeitig. Bei Begegnungen mit mehr als zwei
Mitqualifizierten wird die aufsteigende ID-Reihenfolge für B01 und die
umgekehrte Reihenfolge für B02 verwendet; in P02 werden beide vertauscht.

## Vorab festgelegter K.O.-Baum

| Begegnung | Teilnehmer | Weiter nach |
| --- | --- | --- |
| Q01 | V01 gegen V03 | S01 |
| Q02 | V05 gegen V07 | S01 |
| Q03 | V02 gegen V04 | S02 |
| Q04 | V06 gegen V08 | S02 |
| S01 | Qualifizierte aus Q01 und Q02 | F01 |
| S02 | Qualifizierte aus Q03 und Q04 | F01 |
| F01 | Qualifizierte aus S01 und S02 | Siegergruppe |

Die zwei historischen Kontrollen liegen in unterschiedlichen Hälften.
Die Paarungen werden nicht nach Ergebnissen oder vermeintlicher Stärke
umgestellt. Frühere Läufe dienen nicht zum Seeding oder zur Punktevergabe.

## Entscheidung, Wiederholung und mehrere Sieger

1. Für jeden Kandidaten die bestätigten Negativpunkte aller sechs gültigen
   Läufe des aktuellen Durchgangs ermitteln. Die Definition steht in SCORING.md.
2. Innerhalb derselben Begegnung die Negativpunkte über abgeschlossene
   Durchgänge kumulieren. Alle noch verglichenen Kandidaten haben dabei
   dieselbe gültige Laufzahl. Werte aus früheren Runden zählen hier nicht.
3. Kandidaten oberhalb des kleinsten kumulierten Negativwerts scheiden aus.
   Ein alleiniger Minimalwert entscheidet das Weiterkommen.
4. Teilen mehrere Kandidaten den Minimalwert, wiederholen nur diese den
   Vergleich mit jeweils erneut 2×3 frischen Reviewern. Nicht entschiedene
   Mindestwerte werden nicht durch Positivpunkte oder Bauchgefühl gebrochen.
5. Pro Begegnung höchstens drei Durchgänge: P01 plus maximal P02 und P03.
   Besteht danach Gleichstand, qualifizieren sich alle verbliebenen Kandidaten
   gemeinsam für den nächsten Knoten.
6. Dadurch kann ein Halbfinale oder Finale mehr als zwei Kandidaten haben.
   Jeder erhält dieselben vollständigen 2×3-Blöcke pro Vergleichsdurchgang.
7. Im Finale werden nach anhaltendem Gleichstand alle Minimalwert-Kandidaten
   als gemeinsame Turniersieger geführt. Das gilt ausdrücklich auch für
   wiederholt 0:0:0 und mehr als zwei Finalisten.

Eine Ergebnisänderung nach belegter Neubewertung wird versioniert. Bis dahin
bleiben betroffene Folgerunden ausgesetzt. Keine Umklassifizierung nur, um
einen Gleichstand aufzulösen. Neue Designideen starten kein laufendes Rennen neu.

## Umfang und Grenzen

Ohne Gleichstände: 7 Begegnungen × 2 Kandidaten × 6 Läufe = **84 Läufe**.
Mit Wiederholungen, aber jeweils nur einem Qualifizierten pro Knoten:
höchstens **252 Läufe**. Mit überall anhaltenden Gleichständen und gemeinsamer
Qualifikation: höchstens **432 Läufe** über Viertelfinale, Halbfinale und Finale.
Technisch ungültige Ersatzläufe sind darin nicht enthalten; die Stoppregel
im RUNBOOK verhindert unbegrenzte Ersatzversuche.

Das ist ein vorab begrenztes qualitatives Turnier, kein statistischer
Signifikanznachweis. K.O.-Paarungen und Zufallsschwankungen beeinflussen den
Ausgang. Die feste Quellbasis erlaubt Vergleiche, belegt aber keine generische
Wirksamkeit in anderen Produkten. Eine spätere unabhängige Quellbasis wäre
eine getrennte Bestätigung, kein nachträglich hinzugefügter Tie-Breaker.
