# Bewertung

## Kategorien

| Code | Bedeutung | Negativpunkte |
| --- | --- | --- |
| N | Nach Codeprüfung nicht tragfähige, als gestützt empfohlene Richtung oder unvertretbarer empfohlener Umfang | 1 |
| T | Konkret gestützte fachliche Verbesserungsrichtung; einzelne Designfragen dürfen offen sein | 0 |
| U-O | Ehrlich bedingte Beobachtung oder offener Kandidat außerhalb einer gestützten Empfehlung | 0 |
| U-J | Der Bewertende kann trotz gezielter Prüfung noch nicht sicher zwischen T und N entscheiden | 0 |
| NONE | Keine Empfehlung und keine relevante offene Beobachtung | 0 |
| X | Technisch oder methodisch ungültiger Lauf | Kein Wert; Ersatz erforderlich |

N benötigt eine konkrete, belegte Begründung: etwa falsche Quellenbehauptung,
ein bereits vorhandener Entscheidungsbesitzer ohne erklärten Grenzgewinn,
übernommene Koordination ohne belegte Entlastung oder eine Empfehlung, deren
zentraler Zuschnitt nach dem Code notwendige Unterschiede verwischt. Keine
Fehlervergabe allein wegen fehlender Ausführlichkeit, einer anderen bevorzugten
Architektur, offener API-Details, mangelnder Beweisvollständigkeit oder eines
noch unbekannten Implementierungsaufwands. Fehlt für N die ausreichende
Entscheidungsgrundlage, lautet der Status U-J, nicht vorsorglich N.

Die Selbstbewertung des Reviewers entscheidet die Klasse nicht. Auch
„Richtung gestützt; Umfang braucht Entwurf“ kann N sein, wenn gerade der
Nutzen dieser Richtung nicht trägt. Umgekehrt ist eine gute Richtung nicht
schlecht, nur weil ihre komplette Umsetzung noch entworfen werden muss.

Jede bestätigte negative Empfehlung zählt unabhängig vom gemeldeten
Severity-Level mit einem Punkt. Severity und Reifegrad werden zusätzlich
festgehalten, ändern in dieser Regelversion aber nicht die Turnierwertung.

Ein offener Kandidat ist U-O, sofern er seine Unsicherheit ehrlich darstellt.
Ein im „offenen“ Abschnitt versteckter unbedingter Umsetzungsauftrag wird
nach seiner tatsächlichen Aussage bewertet. Unstrittige Faktenfehler in
reinen Beobachtungen separat protokollieren; ohne empfohlene schädliche oder
unbelegte Richtung entsteht daraus in diesem Turnier kein N.

## Zähleinheit und Wiederholungen

- Gezählt wird eine unabhängig diskutierbare Empfehlung, nicht jede Zeile,
  jeder Satz oder jedes Symptom. Mehrere Symptome derselben Richtung ergeben
  innerhalb eines Berichts höchstens ein N.
- Zwei eigenständig umsetzbare schlechte Richtungen ergeben zwei N.
- Derselbe schlechte Vorschlag in drei unabhängigen Berichten zählt dreimal:
  Die Wiederholung zeigt das Risiko, mit dem ein Nutzer ihn angeboten bekommt.
- Ein guter Kern mit einer nur bedingten Erweiterung ist T plus U-O, nicht N.
  Wird die unbegründete Erweiterung als Teil desselben umzusetzen empfohlenen
  Gesamtpakets verkauft, erhält dieses Paket N. Ein separat gestützter Kern
  darf dokumentiert werden, kompensiert den Fehler aber nicht.
- Belegte positive und negative Teilvorschläge werden nur getrennt gezählt,
  wenn sie auch tatsächlich unabhängig auswählbar sind. Kein künstliches
  Aufsplitten, um Punkte oder Nutzen zu vervielfachen.
- Ausgelassene bekannte Chancen sind keine N. Es gibt keine Finding-Quote.

## 0,3 als getrennte Nutzenanzeige

Pro Kandidat und Begegnung wird zusätzlich P = 0,3 × Anzahl unterschiedlicher
T-Themen notiert. Dasselbe Thema über mehrere Läufe oder Wiederholungen
ergibt hier nur einmal 0,3. Damit belohnt die Anzeige unterschiedliche
brauchbare Richtungen statt Wiederholung oder längere Berichte.

P verändert weder Negativpunkte noch Weiterkommen. Es ist insbesondere
kein Score N − 0,3×T: Mehrere gute Vorschläge dürfen keinen schlechten
ausgleichen. Bei N-Gleichstand folgt gemäß Nutzerwunsch eine Wiederholung.
Nach anhaltendem Gleichstand sind mehrere Sieger möglich. Falls später eine
Nutzenwertung das Weiterkommen bestimmen soll, braucht sie vor dem ersten
Lauf einer neuen Serie eine neue Regelversion.

## Bewertungsverfahren

Nach dem vollständigen Vergleichsdurchgang zunächst die finalen Berichte
unter neutralen Beleg-IDs E0001 usw. lesen, ohne Gegner, Kandidatenansatz oder
Zwischenpunkte als Begründung zu verwenden. Danach jede Empfehlung am
gleichen festen Quellcommit prüfen. Das ist eine bewusst eingeschränkte
Verblindung: Stil kann den Ansatz verraten; vollständige Unkenntnis lässt
sich beim Skill-Autor nicht behaupten.

Für jede Einstufung Quelle/Symbol, zentrale Aussage, Begründung, verbleibende
Unsicherheit und Themen-ID dokumentieren. N muss unabhängig vom Kandidaten
nachvollziehbar sein. Bei echter Unklarheit U-J belassen und vor der
Begegnungsentscheidung mit gezielter Quellenprüfung erneut betrachten.
Bleibt die Unklarheit bestehen, bleibt sie ohne Negativpunkt sichtbar.

Ein einzelner primärer Bewertender (dieser Chat mit Quellenprüfung) bewertet
alle Kandidaten mit derselben Rubrik. Keine wechselnden Bewertungsmaßstäbe
und keine zusätzliche Review-Skill-Kombination. Eine spätere Zweitbewertung
oder menschliche Korrektur wird mit alter und neuer Entscheidung erhalten.

## Fiktive Beispiele; keine Ergebnisse

- A hat 1 N und 10 T, B hat 0 N und keine Findings: B kommt weiter.
- A und B haben je 0 N, aber unterschiedlich viele T: Wiederholung.
- Drei Finalisten haben nach P03 alle 0 N: drei gemeinsame Sieger.
- Eine Richtung trägt, der genaue Zustandszuschnitt ist offen: T.
- Ein vorgeschlagener Gesamtbesitzer ist nicht überzeugend, und der
  Bewertende kann dessen Nutzen noch nicht sicher beurteilen: U-J.
- Ein schlechter Lauf liest den falschen Skill: X; kein Architekturfehlerpunkt.

Reine Formatprobleme (z.B. übersetztes Severity-Label) werden separat
protokolliert. Solange die Empfehlung bewertbar bleibt, beeinflussen sie
die Negativwertung nicht. Bewertungsverhindernde Ausgaben sind X.
