---
name: pragmatic-testing
description: "Allgemeine Testregeln für Coding-Agenten beim Entwickeln, Erstellen, Ändern, Ausführen, Debuggen und Pflegen automatisierter Softwaretests. Schwerpunkte: gezielte Testtiefe während der Entwicklung, bewusste Neubewertung für dauerhafte Produktabsicherung, klare Organisation und Auffindbarkeit des Testbestands, kompakte Standardausgabe mit bedarfsgerechter Diagnose sowie angemessener Testaufwand."
---

# Pragmatic Testing

## Zweck und Schwerpunkte

Optimiere den **gesamten Umgang mit Softwaretests über ihren Lebenszyklus**, nicht nur das Schreiben einzelner Testfälle. Tests sollen die Entwicklung zuverlässig unterstützen und das Produkt dauerhaft absichern, ohne unnötigen Pflegeaufwand, unübersichtliche Testbestände oder ausufernde Standardausgaben zu erzeugen.

**Diese Schwerpunkte steuern deine Entscheidungen:**

1. **Entwicklungsphase:** Für die aktuelle Arbeit so tief und detailliert testen, wie es für Erkenntnis und Fortschritt sinnvoll ist.
2. **Dauerhafte Absicherung:** Neu entstandene oder wesentlich geänderte Prüfungen bewusst auf ihren langfristigen Nutzen bewerten, statt alles unreflektiert zu behalten.
3. **Testorganisation:** Den dauerhaft relevanten Testbestand übersichtlich, auffindbar und eindeutig den abgesicherten Produktbereichen und Zwecken zuordnen.
4. **Testausgabe:** Regelmäßige Erfolge knapp darstellen; aktuelle Entwicklungsfragen und Fehler gezielt mit den nötigen Details untersuchen.
5. **Verhältnismäßigkeit:** Fehlerschutz, Entwicklungszeit, Testlaufzeit, Wartung und zusätzliche Prüfaktivitäten gegeneinander abwägen.

Behandle diese Punkte als zusammenhängende Entscheidungsregeln. Andere Testmethoden und allgemeine Best Practices unterstützen sie, ersetzen sie aber nicht. Nutze die vorhandenen Projektkonventionen und ausdrücklichen Anforderungen.

## 1. Während der Entwicklung gezielt und tief prüfen

Unterscheide die **aktuelle Erkenntnisaufgabe** vom späteren Dauerbetrieb eines Tests.

- Ermittle, welches Verhalten gerade entwickelt, verändert oder untersucht wird und welche Unsicherheiten bestehen.
- Setze dort bei Bedarf detaillierte, explorative oder kurzfristige Diagnoseprüfungen ein. Untersuche relevante Randfälle, Zustände, Übergänge und Fehlerursachen so genau, wie es die Aufgabe erfordert.
- Führe zunächst die unmittelbar relevanten Prüfungen aus und erweitere den Umfang bei erkannten Risiken oder Wechselwirkungen.
- Nutze für die aktuelle Fehlersuche ausführliche Informationen. Lass nicht bei jeder Wiederholung die erfolgreichen Tests anderer, unveränderter Bereiche ihre vollständigen Logs ausgeben.
- Behalte im Blick, dass eine momentan hilfreiche Detailprüfung nicht automatisch ein sinnvoller dauerhafter Regressionstest ist.

Eine tiefe Entwicklungsprüfung darf zeitweise stark auf eine konkrete Hypothese ausgerichtet sein. Prüfe aber auch dann echte Erwartungen statt bloß die aktuelle Implementierung zu bestätigen.

## 2. Übergang zu dauerhaften Tests bewusst gestalten

**Lass Entwicklungsprüfungen nicht allein deshalb dauerhaft liegen, weil sie einmal geschrieben wurden.** Bewerte am Abschluss der betreffenden Arbeit die neu entstandenen oder wesentlich veränderten Tests. Diese Neubewertung betrifft die bearbeiteten Tests, nicht automatisch die gesamte Testsuite.

Beantworte für die dauerhafte Übernahme:

1. **Schutzwert:** Welche fachliche Erwartung, Schnittstelle oder relevante Fehlerart wird abgesichert?
2. **Zusatznutzen:** Welchen Erkenntnis- oder Schutzbeitrag leistet die Prüfung gegenüber bestehenden Tests?
3. **Stabilität:** Bleibt sie bei legitimen internen Änderungen aussagekräftig, statt unnötig zu brechen?
4. **Verlässlichkeit:** Ist die Prüfung reproduzierbar und bei Fehlschlägen verständlich?
5. **Kosten:** Rechtfertigt ihr Schutzwert die Ausführungs-, Diagnose- und Wartungskosten?

Entscheide danach begründet: **behalten, als dauerhaften Regressionstest ausarbeiten, vereinfachen, zusammenführen, gezielt als Diagnoseprüfung weiterverwenden oder entfernen**.

Für dauerhaft wichtige Tests gelten höhere Anforderungen an eindeutige Erwartungen, Verlässlichkeit, Wartbarkeit, Organisation und verständliche Fehlerdiagnose. Gleichzeitig können zusätzliche spezifische Tests dauerhaft nötig sein, wenn sie eigenständige Risiken absichern.

Lösche einen Test niemals nur deshalb, weil er lange grün war, ähnlich aussieht oder dieselben Codezeilen abdeckt. Prüfe vor jeder Konsolidierung, ob einzigartige Eingaben, Zustände, Fehlerarten oder Regressionen verloren gingen. Schwäche keine Assertions ab, nur um einen grünen Lauf zu erhalten.

Diese Trennung beschreibt **unterschiedliche Zwecke und Lebensphasen**, nicht zwingend zwei feste Testarten, Ordner oder technische Systeme.

## 3. Testbestand als Produktabsicherung klar organisieren

**Testorganisation ist eine eigenständige Qualitätsanforderung.** Ein Entwickler oder Agent soll erkennen können, **wo die relevanten Produkttests liegen, welches Verhalten sie absichern und welche davon im jeweiligen Kontext ausgeführt werden**.

- Ermittle die bereits vorhandene Struktur von Testdateien, Testsuiten, Testbefehlen und CI-Ausführungen. Verwende sie als Ausgangspunkt.
- Ordne dauerhafte Tests nachvollziehbar den Produktfunktionen, Modulen, Schnittstellen oder Verhaltensbereichen zu. Wähle eine konsistente Struktur, in der betroffene Tests bei Änderungen auffindbar sind.
- Halte erkennbar, welche Prüfungen zur regelmäßigen Produktabsicherung gehören und welche gerade explorativen, lokalen oder diagnostischen Zwecken dienen. Nutze bestehende Ordner, Konventionen, Markierungen oder Testgruppen, soweit sie dafür geeignet sind.
- Sorge dafür, dass wichtige Regressionstests zuverlässig in den vorgesehenen Testläufen enthalten sind. Ein Test darf nicht nur deshalb als abgesichert gelten, weil die Datei existiert.
- Trenne bei Bedarf die **logische Zuordnung eines Tests** von den **verschiedenen Ausführungsgruppen** (etwa gezielter lokaler Lauf, Smoke-Test, Regression, vollständige Suite). Dupliziere keinen Testcode nur, um dieselbe Prüfung in mehreren Gruppen auszuführen.
- Vermeide verstreute Einzeltests, unklare Namen, parallele Testkopien und zusätzliche Sonderstrukturen ohne erkennbaren Nutzen.

Wenn die bestehende Organisation unübersichtlich ist, schlage oder implementiere **nur bei entsprechendem Auftrag** eine angemessene Verbesserung: zum Beispiel klarere Gruppierung, Tags, ein nachvollziehbarer Suite-Einstiegspunkt oder eine schlanke Übersicht darüber, welche Bereiche abgesichert sind.

Eine zentrale Test-Registry oder zusätzliche Dokumentation ist **eine mögliche Lösung, keine Pflicht**. Entscheidend sind Auffindbarkeit, eindeutiger Zweck, verlässliche Ausführung und geringer Pflegeaufwand.

Pflege die Zuordnung bei relevanten Änderungen mit. Führe nicht bei jeder kleinen Aufgabe ein vollständiges Organisations-Audit durch.

## 4. Testausgabe nach Situation und Zweck steuern

**Standardmäßig kompakt, für die aktuelle Entwicklungsarbeit gezielt detailliert und bei Fehlern diagnostisch ausreichend.**

Unterscheide ausdrücklich:

- **Ausführungsumfang:** Welche Tests liefen tatsächlich?
- **Prüftiefe:** Wie gründlich wurde Verhalten untersucht?
- **Ausgabeumfang:** Wie viele Informationen werden angezeigt?

Ein knapper Bericht darf niemals als Ersatz für ausreichende Tests dienen.

### Regelmäßige und etablierte Prüfungen

- Nutze nach Möglichkeit die Quiet-/Summary-Funktionen vorhandener Test-Runner.
- Zeige kompakt den Gesamtstatus, die Zahl der bestandenen und fehlgeschlagenen Tests sowie relevante übersprungene oder nicht ausgeführte Prüfungen.
- Halte routinemäßig erfolgreiche Tests, insbesondere aus gerade nicht bearbeiteten Produktbereichen, in der Standardausgabe kurz.
- Hebe neue, relevante oder ungewöhnliche Fehler deutlich hervor. Verwechsle nicht ausgeführte Prüfungen nicht mit erfolgreichen.

### Aktuelle Entwicklung und Fehlerdiagnose

- Stelle für den gerade bearbeiteten Bereich bei Bedarf ausführlichere Zwischenergebnisse bereit.
- Zeige bei Fehlschlägen zunächst den betroffenen Test, die geprüfte Erwartung und die wesentliche Abweichung.
- Nutze bei Bedarf zusätzliche Logs, Stacktraces, Testdaten und Umgebungsinformationen für die betreffende Prüfung. Bewahre relevante Details abrufbar auf, statt sämtliche erfolgreichen Logs in die Hauptausgabe zu mischen.
- Untersuche, ob die Ursache im Produkt, im Test, in der Erwartung oder in der Umgebung liegt, bevor du eine Korrektur vornimmst.

Nutze vorhandene Runner-, CI- und Report-Funktionen. Führe keine neue Dashboard- oder Reporting-Infrastruktur ein, wenn eine einfache Konfiguration bereits genügt.

## 5. Testaufwand und dauerhaften Nutzen abwägen

**Optimiere nicht auf möglichst viele oder möglichst wenige Tests, sondern auf sinnvolle Absicherung bei angemessenem Gesamtaufwand.**

- Beurteile neue Tests nach Risiko, zusätzlichem Fehlererkennungswert, Pflegeaufwand, Laufzeit und Diagnosequalität.
- Prüfe vorhandene Tests, bevor du weitere erzeugst. Ergänze fehlende Absicherung, statt nur Testanzahl oder Coverage zu erhöhen.
- Wähle Testarten und Ausführungszeitpunkte passend zur Aufgabe und zur vorhandenen Infrastruktur. Beginne fokussiert; erweitere Prüfungen bei erhöhtem Risiko oder größeren Änderungen.
- Berücksichtige den langfristigen Preis unnötig strenger, eng implementierungsgebundener und wiederholter Tests.
- Entferne aber keine wichtige Absicherung nur zur Beschleunigung. Begründe wesentliche Änderungen am dauerhaften Testbestand.
- Halte den Aufwand der Testoptimierung selbst verhältnismäßig: Keine regelmäßigen Komplett-Audits, umfangreichen Metriksysteme oder erzwungenen Refactorings ohne Anlass.

Feste Coverage-Prozentsätze, Testpyramiden-Verhältnisse, TDD und Mutation Testing sind **keine universellen Pflichten**. Nutze sie, wenn Projektvorgaben, Risiken und ein klarer zusätzlicher Nutzen dafür sprechen.

## 6. Unterstützende Testqualitätsregeln

Wende die folgenden Grundlagen an, ohne daraus automatisch zusätzliche Testarbeit zu erzeugen:

- Teste vorzugsweise beobachtbares Verhalten, Verträge und begründete Erwartungen statt zufälliger Implementierungsdetails.
- Gib Tests aussagekräftige Namen und fokussiere Assertions auf relevante Ergebnisse.
- Berücksichtige positive, negative, Grenz- und Zustandsfälle nach ihrer tatsächlichen Bedeutung; erzeuge sie nicht schematisch.
- Halte Tests möglichst unabhängig, reproduzierbar und verständlich. Nutze gemeinsame Hilfen oder parametrisierte Tests, wenn sie die Wartbarkeit verbessern.
- Mocke Abhängigkeiten nur soweit sinnvoll; wenn das Zusammenspiel selbst geprüft werden soll, verwende geeignete kontrollierte Integrationen.
- Prüfe insbesondere bei neu erzeugten KI-Tests, ob die Assertions den beabsichtigten Fehler überhaupt erkennen würden. Ein grüner Test allein ist kein Qualitätsbeweis.
- Nutze bei Bedarf eine gezielte Gegenprobe oder Mutation, nicht automatisch für jede neue Prüfung.
- Sichere einen behobenen Fehler durch einen geeigneten Regressionstest ab, wenn er eine relevante wiederkehrende Fehlerart darstellt und sinnvoll automatisiert prüfbar ist.

## 7. Anwendung und Abschluss

Wende die Regeln **situationsabhängig** an: beim Erstellen, Ändern, Ausführen, Debuggen und Pflegen von Tests. Dieser Skill ist eine fortlaufende Arbeitsorientierung, **kein Auftrag, bei jeder Gelegenheit die gesamte Testsuite zu reorganisieren oder zu reviewen**.

Bei jeder Aufgabe:

1. Kläre den unmittelbaren Testzweck und orientiere dich an den vorhandenen Projektstrukturen.
2. Nutze während der Arbeit die dafür nötige Testtiefe und Diagnose.
3. Bewerte neu entstandene oder wesentlich geänderte Tests hinsichtlich dauerhafter Absicherung und ordne sie sinnvoll ein.
4. Führe die angemessenen Prüfungen aus und berichte kompakt; gehe bei Fehlern gezielt ins Detail.
5. Benenne relevante Restunsicherheiten und wesentliche Änderungen am dauerhaften Testbestand.

Berichte nur durchgeführte Prüfungen als durchgeführt. Eine grüne Teilmenge ist kein vollständiger Produkttest. Erkläre Entscheidungen ausführlicher, wenn dauerhaft wichtige Tests verändert oder entfernt werden sollen.

**Leitprinzip:** Entwicklungsprüfungen sollen Erkenntnis und Fortschritt ermöglichen. Dauerhafte Tests sollen das Produkt verlässlich absichern, klar organisiert sein und im Normalbetrieb wenig Informationsrauschen erzeugen. Jede zusätzliche Testaktivität muss ihren Nutzen gegenüber ihrem Aufwand rechtfertigen.
