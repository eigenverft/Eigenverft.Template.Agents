# Kandidatenregister

Alle Kandidaten sind vollständige portable Skills mit demselben Namen,
Trigger und Review-Gegenstand. IDs gehören zur Experimentverwaltung.

| ID | Blickwinkel / Ansatz | Hypothese |
| --- | --- | --- |
| [V01](candidates/V01/review-abstraction-and-responsibility-boundaries/SKILL.md) | Historical maturity baseline | Die frühere offene Richtungsbewertung erhält nützliche Kandidaten, kann aber Workflow-Zusammenfassungen zu großzügig empfehlen. |
| [V02](candidates/V02/review-abstraction-and-responsibility-boundaries/SKILL.md) | Decision ownership baseline | Die zuletzt verschärfte Betrachtung von Entscheidungsbesitz und verborgenem Wissen begrenzt unbegründete Zusammenfassungen. |
| [V03](candidates/V03/review-abstraction-and-responsibility-boundaries/SKILL.md) | State and invariant ownership | Zusammengehörige Zustandsregeln ergeben bessere Grenzen als die gemeinsame Zugehörigkeit zu einem Ablauf. |
| [V04](candidates/V04/review-abstraction-and-responsibility-boundaries/SKILL.md) | Concrete change and propagation | Ein konkreter Vorher-Nachher-Vergleich gewöhnlicher Änderungen entlarvt behauptete, aber nicht tatsächliche Entkopplung. |
| [V05](candidates/V05/review-abstraction-and-responsibility-boundaries/SKILL.md) | Consumer contract and hidden knowledge | Der Nutzen wird klarer, wenn die Review-Perspektive von den Operationen und dem Wissen der Verbraucher ausgeht. |
| [V06](candidates/V06/review-abstraction-and-responsibility-boundaries/SKILL.md) | Benefit gate against existing alternatives | Ein ausdrückliches Nutzen-Gate gegen bestehende und kleinere Alternativen reduziert zu große, unbegründete Besitzer. |
| [V07](candidates/V07/review-abstraction-and-responsibility-boundaries/SKILL.md) | Internal challenge and falsification | Eine interne Gegenprüfung verwirft schwache Erklärungen, ohne jede Idee schon in der Entdeckung abzuwürgen. |
| [V08](candidates/V08/review-abstraction-and-responsibility-boundaries/SKILL.md) | State, change, and contract combined | Zustand, Änderung und Verbraucher-Vertrag stützen gemeinsam brauchbare Richtungen und begrenzen pauschale Zusammenfassungen. |

## Vergleichbarkeit

V01 und V02 sind bytegetreue historische Kontrollen. Sie unterscheiden sich
an mehreren bereits dokumentierten Stellen; sie sind keine Ein-Faktor-
Experimente. V03 bis V08 nutzen denselben neutralisierten gemeinsamen Kern
aus V01 und unterscheiden sich ausschließlich im Abschnitt `Review Approach`.
Der gemeinsame Kern liegt unter [design/common-core.md](design/common-core.md).
Damit gibt es sechs neue Ansätze und zwei nachvollziehbare Vergleichsstände.

Der gemeinsame Kern behält Aktivierung, Read-only-Grenzen, fachlichen Fokus,
proportionale Belege, Gegenargumente, stabile Finding-Referenzen, Severity
und Reifegrad bei. Er schreibt den neuen Ansätzen nicht zusätzlich das
vollständige Wissensreduktions-Gate von V02 vor. Er verlangt weiterhin einen
konkreten Nachteil und eine gestützte Verbesserungsrichtung.

V08 ist eine vorab festgelegte Kombination von Blickwinkeln, keine nach einem
Zwischenergebnis zusammengestellte Sieger-Mischung. Weitere Mischungen oder
Textkorrekturen bekommen eine neue ID und gehören in ein späteres Turnier.
Nach dem ersten Dispatch werden weder Kandidaten noch Wertung angepasst.

Es gibt keine Themen-Blacklist und keine im Skill eingebauten erwarteten
Produkt-Findings. Ein bestimmter Lebenszyklus oder Mechanismus ist nicht
automatisch gut oder schlecht; die jeweilige Empfehlung wird am Code geprüft.
