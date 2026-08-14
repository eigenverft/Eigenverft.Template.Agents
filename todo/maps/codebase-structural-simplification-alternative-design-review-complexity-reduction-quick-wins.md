Akzeptiere die bestehende Struktur nicht als gegeben. Prüfe, ob derselbe Effekt mit einem wesentlich einfacheren Design erreicht werden kann.

Ist das wirklich eine andere Implementierung oder nur dieselbe Idee in einer anderen Form?

Welche Komplexität entsteht nur durch die gewählte Struktur und könnte durch ein anderes Modell vollständig entfallen?

Wie würde man dieselbe Funktion heute möglichst einfach aufbauen, wenn die bestehende Implementierung keine Vorgabe wäre?

Welche einfacheren Lösungsmodelle sind üblich und wie erreichen andere denselben Effekt mit weniger Mechanismen, Zuständen und Sonderlogik?

Suche bewusst nach mehreren möglichen Wegen. Betrachte kleine Vereinfachungen ebenso wie grundsätzlich andere Designs und stelle sinnvolle Zielbilder nebeneinander.

Prüfe für jeden Ansatz, unter welchen Voraussetzungen er gut passt, welche Stärken er hat und wodurch er sich von den Alternativen unterscheidet.

Prüfe auch, ob sich mehrere Ansätze sinnvoll kombinieren lassen und dadurch eine noch einfachere Gesamtlösung entsteht.

Suche nicht nur nach weniger Code, sondern nach einer einfacheren Struktur hinter dem Code.

Bevorzuge wenige klare Mechanismen gegenüber vielen spezialisierten Lösungen.

Bewerte die Ansätze im Verhältnis aus gewonnener Einfachheit, reduzierter Komplexität, notwendigem Umbau und den Bedingungen, unter denen sie sinnvoll einsetzbar sind.

## Ergebnistabelle

Vergib für jeden betrachteten Bereich eine einfache Referenz wie `A`, `B`, `C`.

Mehrere mögliche Zielbilder innerhalb eines Bereichs erhalten Referenzen wie `A1`, `A2`, `A3`.

Kombinationen können beispielsweise als `A1+A2` oder `A2+B1` referenziert werden.

| Ref | Was ist heute da?                     | Was soll erreicht werden?                                      | Mögliches Zielbild      | Was wird einfacher oder entfällt?                           | Einfachheitsgewinn                 | Änderungsaufwand       | Risiko                 | Voraussetzungen                  | Trade-offs                               |
| --- | ------------------------------------- | -------------------------------------------------------------- | ----------------------- | ----------------------------------------------------------- | ---------------------------------- | ---------------------- | ---------------------- | -------------------------------- | ---------------------------------------- |
| A1  | Aktuelle Struktur in einfachen Worten | Gewünschter Effekt unabhängig von der heutigen Implementierung | Erster möglicher Ansatz | Was dadurch reduziert oder vollständig entfernt werden kann | gering / mittel / hoch / sehr hoch | gering / mittel / hoch | gering / mittel / hoch | Wann der Ansatz gut funktioniert | Relevante Nachteile oder Einschränkungen |
| A2  | …                                     | …                                                              | Alternative zu A1       | …                                                           | …                                  | …                      | …                      | …                                | …                                        |
| B1  | …                                     | …                                                              | Weiteres Zielbild       | …                                                           | …                                  | …                      | …                      | …                                | …                                        |

Führe mehrere Zielbilder auf, wenn mehrere Wege plausibel sind. Vermeide künstliche Präzision bei Bewertungen. Die Werte sollen eine schnelle relative Einschätzung ermöglichen.

## Kurzreport

Nutze ausschließlich die Referenzen aus der Tabelle, damit Aussagen leicht nachvollziehbar bleiben.

### Größte Vereinfachungen

Nenne die Ansätze mit dem größten strukturellen Gewinn und erkläre kurz warum.

### Bestes Verhältnis aus Gewinn und Aufwand

Hebe die Ansätze hervor, die viel Einfachheit bei vergleichsweise geringem Umbau bringen.

### Grundsätzlich andere Designs

Nenne Ansätze, die nicht nur bestehenden Code vereinfachen, sondern das heutige Lösungsmodell ersetzen.

### Sinnvolle Kombinationen

Zeige Kombinationen, wenn gemeinsam ein besseres Gesamtbild entsteht.

### Empfehlung

Nenne die stärksten Kandidaten anhand ihrer Referenzen und begründe knapp die Reihenfolge.

Die Empfehlung soll nicht zwanghaft einen einzelnen Gewinner bestimmen. Wenn mehrere Ansätze unterschiedliche sinnvolle Zielbilder darstellen, zeige klar, wann `A1`, `A2` oder eine Kombination wie `A1+B1` jeweils die bessere Wahl ist.

## Whitelist / Quick Wins

Erstelle am Ende eine nummerierte Whitelist konkreter Änderungen, die sich vergleichsweise sicher und sinnvoll umsetzen lassen.

Jeder Punkt muss eindeutig auf eine oder mehrere Referenzen aus der Tabelle verweisen.

Die Nummern dienen als direkte Arbeitsanweisung. Die Liste muss deshalb so formuliert sein, dass anschließend beispielsweise einfach gesagt werden kann:

`Mache 1, 2 und 5.`

Format:

1. **[A1] Kurzer Name der Änderung**
   Konkrete Änderung in einfachen Worten. Kurz nennen, was dadurch einfacher wird oder entfällt.

2. **[B1] Kurzer Name der Änderung**
   Konkrete Änderung und erwarteter Effekt.

3. **[A2+B1] Kurzer Name der kombinierten Änderung**
   Konkrete Kombination und warum sie gemeinsam sinnvoll ist.

Sortiere die Whitelist bevorzugt nach:

1. hohem Einfachheitsgewinn,
2. geringem Risiko,
3. geringem bis überschaubarem Änderungsaufwand,
4. möglichst wenig Abhängigkeit von anderen Änderungen.

Nimm nur Änderungen in die Whitelist auf, die ausreichend klar verstanden und begründbar sind. Unsichere, stark invasive oder von offenen Annahmen abhängige Vorschläge gehören nicht in die Whitelist, sondern bleiben im Report.

Wenn sinnvoll, ergänze hinter jedem Punkt eine kompakte Kennzeichnung wie:

`Gewinn: hoch | Aufwand: gering | Risiko: gering`

So entsteht am Ende eine kurze, direkt ausführbare Auswahl, ohne die Details aus Tabelle und Report zu verlieren.
