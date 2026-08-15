# Generische Integration in die bestehende Test-Infrastruktur

Alle in diesem Prompt beschriebenen Konzepte wie:

- Testgruppen
- Teststufen
- Ausführungsreihenfolgen
- Testselektion
- Change-to-Test-Mapping
- Fail-Fast
- Risiko-Klassifizierung
- Full Regression
- gezielte Testausführung

sind **logische Konzepte und keine Vorgabe für eine bestimmte technische Implementierung oder ein bestimmtes Datenformat**.

## Bestehende Mechanismen bevorzugen

Analysiere zuerst, wie das vorhandene Projekt Tests bereits:

- definiert
- gruppiert
- benennt
- markiert
- filtert
- startet
- orchestriert
- parallelisiert
- cached
- in CI ausführt

Finde anschließend einen Weg, die gewünschte Strategie **mit den bereits vorhandenen Mechanismen der Test-Suite möglichst gleichwertig umzusetzen**.

Bevorzuge immer bestehende:

- Test-Suites
- Test-Projekte
- Targets
- Tasks
- Tags
- Labels
- Marker
- Kategorien
- Filter
- Verzeichnisstrukturen
- Namenskonventionen
- Build-System-Funktionen
- Test-Runner-Funktionen
- CI-Jobs
- Dependency-Graphen
- vorhandene Selektionsmechanismen

Erfinde keine neue Konfigurationsschicht, wenn die bestehende Infrastruktur das gewünschte Verhalten bereits ausdrücken kann.

---

# Keine Formatvorgaben

Dieser Prompt schreibt **kein bestimmtes Konfigurationsformat** vor.

Insbesondere bedeutet eine Anforderung wie:

> Definiere logische Testgruppen.

nicht:

> Erzeuge eine neue JSON-, YAML- oder sonstige Konfigurationsdatei.

Stattdessen:

1. Untersuche die vorhandene Test-Infrastruktur.
2. Ermittle, wie Testgruppen dort bereits ausgedrückt werden können.
3. Verwende diese Mechanismen.
4. Ergänze bestehende Strukturen nur dort, wo tatsächlich etwas fehlt.
5. Führe neue Infrastruktur nur ein, wenn keine gleichwertige bestehende Möglichkeit vorhanden ist.

---

# Testgruppen

Ermittle sinnvolle logische Gruppen wie beispielsweise:

- schnelle lokale Tests
- Unit-Tests
- Komponenten-Tests
- Integrations-Tests
- Contract-Tests
- Datenbanktests
- Smoke-Tests
- End-to-End-Tests
- vollständige Regression

Diese Bezeichnungen sind Beispiele für **Testrollen**, nicht zwingend Namen, die im Projekt eingeführt werden sollen.

Übertrage diese Rollen auf die bereits vorhandene Struktur des Projekts.

Wenn das Projekt bereits andere Begriffe oder Gruppierungen verwendet, behalte diese möglichst bei.

---

# Ausführungsreihenfolge

Definiere eine sinnvolle Reihenfolge vorhandener Testgruppen nach dem Prinzip:

**schnell und spezifisch → breiter → integrationsintensiver → teuer → vollständige Regression**

Nutze dafür die vorhandenen Ausführungsmöglichkeiten des Projekts.

Die Reihenfolge soll nachvollziehbar und reproduzierbar sein.

Es muss klar bestimmbar sein:

- welche Testmenge zuerst ausgeführt wird
- welche danach folgt
- unter welchen Bedingungen weitere Testmengen notwendig sind
- wann eine vollständige Regression erforderlich ist
- wann aufgrund eines Fehlers frühzeitig abgebrochen werden kann

---

# Auswahl relevanter Tests

Bei jeder Änderung muss vor der Testausführung bestimmt werden:

1. Welche Teile des Produktionscodes wurden verändert?
2. Welche Komponenten können direkt oder indirekt betroffen sein?
3. Welche vorhandenen Tests prüfen diese Komponenten?
4. Welche bestehenden Testgruppen enthalten diese Tests?
5. Welche Teststufe ist aufgrund des Änderungsrisikos zusätzlich erforderlich?

Wähle anschließend **die kleinste ausreichend sichere Menge vorhandener Tests und Testgruppen**.

Starte nicht automatisch die gesamte Test-Suite.

---

# Mehrere Testgruppen

Wenn mehrere Testgruppen notwendig sind, verwende die vorhandene Infrastruktur so, dass eindeutig festgelegt werden kann:

- welche Gruppen ausgeführt werden
- in welcher Reihenfolge sie ausgeführt werden
- welche davon verpflichtend sind
- welche nur unter bestimmten Bedingungen erforderlich sind
- ob nach einem Fehler abgebrochen werden soll

Falls der bestehende Test-Runner mehrere Gruppen in einem Aufruf unterstützt, kann dieser Mechanismus verwendet werden.

Falls separate Aufrufe erforderlich sind, verwende diese.

**Das gewünschte Verhalten ist entscheidend, nicht die technische Repräsentation.**

---

# Change-to-Test-Zuordnung

Versuche eine nachvollziehbare Beziehung herzustellen zwischen:

**geändertem Produktionscode → betroffenen Komponenten → relevanten Tests → vorhandenen Testgruppen**

Nutze dafür vorhandene Informationen wie:

- Dependency Graphs
- Build Targets
- Test-Coverage-Daten
- Import-/Modulabhängigkeiten
- Test-Metadaten
- bestehende CI-Abhängigkeiten
- Testhistorie

Falls das Projekt bereits Mechanismen für "affected tests", "related tests", "test selection" oder ähnliche Funktionen besitzt, verwende diese bevorzugt.

---

# Persistenz der Teststrategie

Wenn dauerhaftes Wissen über Testgruppen oder Testselektion sinnvoll ist, prüfe zuerst, ob es bereits einen geeigneten Ort dafür gibt.

Beispiele können sein:

- bestehende Test-Konfiguration
- Build-Konfiguration
- CI-Konfiguration
- Test-Runner-Konfiguration
- vorhandene Projektdokumentation
- bestehende Agent-Instructions

Erstelle **nicht automatisch eine neue Datei**.

Eine neue Struktur darf nur eingeführt werden, wenn sie einen klaren Mehrwert bietet und keine gleichwertige bestehende Lösung vorhanden ist.

---

# Grundsatz

Bei allen Anweisungen dieses Prompts gilt:

> Übertrage das beschriebene Ziel auf die vorhandene Architektur, das vorhandene Build-System und die vorhandene Test-Infrastruktur.

Nicht:

> Implementiere das Beispiel wörtlich.

Beispiele, Kategorien und Begriffe dienen ausschließlich dazu, die gewünschte Semantik zu erklären.

Die vorhandene Projektstruktur hat Vorrang, sofern damit das gleiche Sicherheits- und Qualitätsniveau erreicht werden kann.

---

# Zielzustand

Am Ende soll der Agent sagen können:

- welche vorhandenen Testgruppen existieren
- welche davon für die aktuelle Änderung relevant sind
- warum sie relevant sind
- in welcher Reihenfolge sie ausgeführt werden
- welche teuren Gruppen bewusst ausgelassen werden
- unter welcher Bedingung diese später ausgeführt werden müssen
- wann eine vollständige Regression notwendig ist

Dabei soll die bestehende Test-Infrastruktur möglichst erhalten und verbessert werden, anstatt parallel dazu eine neue Test-Infrastruktur aufzubauen.
