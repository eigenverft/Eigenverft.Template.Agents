---
name: review-abstraction-and-responsibility-boundaries
description: Use for a read-only review when the user requests an assessment of abstraction boundaries and responsibility separation in existing code, especially whether coherent behavior, state, and rules are effectively encapsulated and ordinary changes remain local. Examine practical opportunities for focused subobjects, modules, or systems without prescribing interfaces, classes, or patterns. Report source-grounded recommendations without modifying files or executing project code.
---

# Review Abstraction and Responsibility Boundaries

Untersuche, ob zusammengehöriges Verhalten, Zustand und Regeln einen
erkennbaren Verantwortungsbereich bilden und wirksam gekapselt sind.

Der praktische Maßstab lautet:

> Lässt sich eine gewöhnliche Änderung dieses Verhaltens überwiegend im
> zuständigen Bereich durchführen, ohne dafür unnötig andere
> Verantwortungen verstehen oder bearbeiten zu müssen?

Suche sowohl nach fehlenden Grenzen als auch nach Grenzen, die
zusammengehörige Verantwortung unnötig zerstreuen.

## Aktivierung und Arbeitsmodus

Verwende diesen Skill bei ausdrücklichem Aufruf oder einer ausdrücklich
angeforderten Prüfung von Abstraktionsgrenzen, Verantwortungstrennung
oder Kapselung.

Ein allgemeiner Implementierungs-, Bugfix- oder Review-Auftrag aktiviert
diesen speziellen Review nicht automatisch.

Arbeite ausschließlich lesend und berichtend:
- Lies vorhandenen Quellcode und relevante Verträge.
- Lies bei Bedarf Tests, Dokumentation und Änderungshistorie als Evidenz.
- Verändere keine Dateien und erzeuge keine Patches.
- Führe keinen Projektcode, keine Builds, Tests oder Generatoren aus.
- Implementiere keine vorgeschlagene Alternative.

Halte den Untersuchungsumfang am Auftrag ausgerichtet. Verfolge
Abhängigkeiten nur so weit, wie es für eine belastbare Einschätzung
der betrachteten Verantwortung erforderlich ist.

## Schwerpunkt

Prüfe fachliche und technische Teilverantwortungen innerhalb vorhandener
Software, insbesondere:

- zusammengehöriges Verhalten und dessen Zustand,
- Regeln und zulässige Zustandsänderungen,
- Subobjekte, Komponenten, Module und Systeme,
- Algorithmus- und Verhaltensgrenzen,
- Zusammenarbeit zwischen unterschiedlichen Verantwortungen,
- mehrere Ebenen von Abstraktion und Komposition.

Betrachte technische Mechanismen danach, welche Verantwortung sie
tatsächlich begrenzen.

Eine Klasse, ein Interface, eine Datei oder eine Methodenzerlegung
schafft allein noch keine wirksame Verantwortungsgrenze.

Dies ist kein allgemeiner Stil-, Fehler-, Performance- oder
Gesamtarchitekturreview. Berücksichtige solche Aspekte, wenn sie die
betrachtete Grenze oder eine vorgeschlagene Alternative wesentlich
beeinflussen.

## Leitgedanken

### Verantwortung konkret benennen

Eine Verantwortung besitzt eine verständlich beschreibbare Aufgabe
und die dafür maßgeblichen Entscheidungen oder Regeln.

Benenne beispielsweise:
- welche Ergebnisse ein Bereich bestimmt,
- welchen Zustand er verwaltet,
- welche gültigen Übergänge er schützt,
- welchen Mechanismus er kapselt,
- welche Zusammenarbeit er koordiniert.

Bezeichnungen wie „verarbeitet Daten“ oder „enthält Geschäftslogik“
reichen zur Begründung einer neuen Grenze nicht aus.

Ein Arbeitsschritt ist nicht automatisch eine eigenständige
Verantwortung. Umgekehrt können mehrere Methoden gemeinsam eine
Teil­verantwortung bilden, deren Zustand und Regeln bisher mit anderen
Aufgaben vermischt sind.

### Kapselung an ihrer Wirkung beurteilen

Eine wirksame Grenze erlaubt ihren Nutzern, mit einer Aufgabe zu
arbeiten, ohne deren interne Durchführung ständig rekonstruieren
zu müssen.

Prüfe deshalb:
- Was erledigt der Bereich eigenständig?
- Welche Operationen bietet er dafür an?
- Welchen Zustand darf er verändern?
- Welche internen Regeln müssen andere Bereiche weiterhin kennen?
- Können andere Bereiche seine vorgesehenen Operationen umgehen?

Private Felder allein garantieren diese Wirkung nicht.
Gemeinsame Speicherung schließt sie nicht aus.

### Form dem Problem anpassen

Eine passende Grenze kann durch ein Objekt, Subobjekt, eine Funktion,
ein Modul, ein System oder einen anderen geeigneten Mechanismus
entstehen.

Ein eigenes Objekt kann Zustand und Regeln einer Teilverantwortung
zusammenführen. Ein System kann dieselbe Verantwortung für einen
gemeinsamen Datenbestand erfüllen.

Ein Interface kann einen nützlichen Vertrag ausdrücken. Es ist weder
Voraussetzung noch Beweis gelungener Kapselung.

## Vorgehen

### 1. Tatsächliche Verantwortungen rekonstruieren

Lies die relevante Implementierung und den notwendigen Nutzungskontext.

Ermittle:
- welche unterschiedlichen Aufgaben und Entscheidungen vorkommen,
- welcher Zustand jeweils dazu gehört,
- welche Regeln gültige Änderungen bestimmen,
- wer diesen Zustand tatsächlich liest und verändert,
- wie die Verantwortungen zusammenarbeiten.

Orientiere dich an tatsächlichem Verhalten und Zugriffen. Namen,
Dateigrenzen und Kommentare sind Hinweise, keine abschließenden Belege.

Berücksichtige Konstruktion, Lebensdauer und Aufräumen, soweit sie
den Zuschnitt beeinflussen.

### 2. Zusammengehörige Teilverantwortungen suchen

Achte auf Bereiche, in denen Verhalten, Zustand und Regeln erkennbar
zusammengehören, aber bislang über fremde Aufgaben verteilt sind.

Prüfe insbesondere:
- Vermischt eine Einheit mehrere unabhängig verständliche Aufgaben?
- Benötigen bestimmte Methoden eine zusammengehörige Zustandsgruppe?
- Müssen fremde Bereiche diese Zustandsgruppe nach deren internen
  Regeln bearbeiten?
- Muss eine gewöhnliche Änderung einer Aufgabe durch andere Aufgaben
  hindurchgeführt werden?
- Könnte ein eigener Verantwortungsbereich sinnvolle Operationen
  anbieten und interne Entscheidungen selbst übernehmen?

Eine solche Möglichkeit kann auch ohne bisherigen Bug, dokumentierte
Änderungsserie oder zweite Implementierung relevant sein.

Begründe ihren Nutzen anhand des gelesenen Codes. Die bloße Möglichkeit,
Code in eine neue Klasse zu verschieben, genügt nicht.

### 3. Bestehende Grenzen auf Wirksamkeit prüfen

Untersuche bei ausgelagerten Einheiten:
- Besitzen sie ihre Aufgabe tatsächlich?
- Oder arbeiten sie weiterhin beliebig in den Interna ihres
  bisherigen Eigentümers?
- Erhalten sie genau die benötigten Informationen und Fähigkeiten?
- Müssen ihre Nutzer interne Zustände oder Aufrufreihenfolgen kennen?
- Verbergen sie eine eigenständige Entscheidung oder verschieben sie
  hauptsächlich Code und Navigation?

Verfolge auch indirekte Zugriffe über veränderbare Collections,
Rückverweise, Contexts, globale Zugriffe, Callbacks und Events,
wenn sie für die Grenze relevant sind.

Eine breite Referenz ist ein Untersuchungssignal. Entscheidend sind
ihre tatsächliche Verwendung und die dadurch entstehenden Abhängigkeiten.

Unterscheide syntaktische Verschachtelung, Laufzeitkomposition und
fachliche Teilverantwortung. Keine dieser Formen beweist automatisch
die jeweils anderen.

### 4. Eine passende Änderungsgegenprobe durchführen

Prüfe interessante Grenzen anhand einer gewöhnlichen, nachvollziehbaren
Änderung des betreffenden Verhaltens.

Nutze vorhandene Anforderungen, Varianten oder bekannte Änderungen.
Eine ausdrücklich hypothetische Gegenprobe ist ebenfalls zulässig.
Erfinde daraus keine Produktplanung.

Verfolge:
- Welche Entscheidung würde sich ändern?
- Welche Bereiche müsste man dafür verstehen?
- Welche Bereiche müsste man tatsächlich bearbeiten?
- Warum wäre jeder dieser Bereiche betroffen?

Unterscheide notwendige Zusammenarbeit von vermeidbarer Verflechtung.

Eine Anforderung kann mehrere Verantwortungen berechtigterweise
verändern. Problematisch wird es, wenn ein Bereich dafür unnötig
fremde Implementierungsdetails verstehen oder dieselbe fremde Regel
erneut interpretieren muss.

Zähle betroffene Dateien nicht als Qualitätsmaß.

### 5. Eine konkrete alternative Grenze beschreiben

Bei einer empfohlenen Trennung erläutere:
- welche Aufgabe der neue Bereich übernimmt,
- welcher Zustand und welche Regeln dazu gehören,
- welche Operationen seine Nutzer benötigen,
- welche internen Entscheidungen dadurch verborgen bleiben,
- welche gewöhnlichen Änderungen dadurch lokaler werden.

Prüfe auch, ob zusammengehörige Regeln zum bisherigen Besitzer
zurückgeführt oder bestehende Einheiten zusammengelegt werden sollten.

Wähle die passende technische Form erst danach.

„Service extrahieren“ oder „Interface hinzufügen“ ist keine
ausreichende Empfehlung.

Ein zusätzlicher Variationsmechanismus braucht einen konkreten Nutzen.
Unterschiedliche Werte können durch Daten ausgedrückt werden;
unterschiedliche Regeln können eine eigene Verhaltensgrenze
rechtfertigen.

### 6. Die Alternative gegen die Praxis prüfen

Beurteile die relevante Gesamtwirkung:
- Entfällt tatsächlich fremdes Wissen?
- Werden Zustandsänderungen klarer verantwortet?
- Bleibt notwendige Zusammenarbeit verständlich?
- Entstehen zusätzliche Weiterleitungen oder versteckte Abhängigkeiten?
- Werden Initialisierung und Lebensdauer schwieriger?
- Wandern bisher geschützte Regeln zu den Aufrufern?
- Bleiben notwendige Konsistenz und gemeinsame Operationen erhalten?
- Sind relevante Laufzeit- und Speicherbedingungen berücksichtigt?

Prüfe naheliegende Gegenargumente, bevor du eine Empfehlung festhältst.

Verlange keine vollständige Neuarchitektur. Empfehle einen angemessenen
Zuschnitt, der das konkrete Problem vollständig genug adressiert.

## Regeln gegen Fehlurteile

Erzeuge kein Finding allein wegen:
- großer Klassen oder langer Methoden,
- vieler oder weniger Dateien,
- fehlender Interfaces oder Patterns,
- nur einer produktiven Implementierung,
- gemeinsamer Daten oder mehrerer Schreiber,
- zentraler Koordination,
- verschachtelter Typen,
- einer Verzweigung,
- mehrerer betroffener Bereiche bei einer Änderung.

Beachte beide Richtungen:
- Methoden können eine zusammenhängende Aufgabe bereits passend gliedern.
- Eine eigene Teilverantwortung kann trotz sauberer Methodenstruktur
  noch wirksamere Kapselung benötigen.
- Eine neue Klasse kann dieselbe Verflechtung fortsetzen.
- Mehrere kleine Einheiten können eine einzige Regel unnötig zerstreuen.
- Ein dünner Adapter kann eine reale Vertragsgrenze schützen.
- Zentrale Koordination kann eine notwendige Gesamtverantwortung besitzen.

Erzwinge weder zusätzliche Abstraktion noch maximale Direktheit.

## Evidenz und Empfehlungen

Stütze Feststellungen auf konkrete Symbole, Zugriffe und Verträge.

Trenne:
- beobachtete Struktur,
- daraus abgeleitetes Änderungs- oder Verständnisproblem,
- vorgeschlagene Verbesserung.

Eine sinnvolle Empfehlung benötigt keinen nachgewiesenen Laufzeitfehler.
Sie benötigt eine nachvollziehbare Verantwortung, einen konkreten
praktischen Nachteil und eine plausible Verbesserung.

Erhalte interessante, noch nicht ausreichend geklärte Möglichkeiten
als ausdrücklich bedingte Hinweise. Benenne den fehlenden Kontext,
der ihre Bewertung wesentlich verändern würde.

Verlange keine mathematische Beweisvollständigkeit und stelle
Vermutungen nicht als bestätigte Mängel dar.

## Ausgabe

Beginne mit einer knappen Einordnung des untersuchten Umfangs.

Stelle anschließend die wesentlichen Befunde dar. Jeder Befund soll
verständlich verbinden:

1. Fundstelle und betroffene Verantwortung.
2. Konkrete Vermischung oder unwirksame Grenze.
3. Praktische Auswirkung auf Verständnis oder Änderungen.
4. Vorgeschlagener Zuschnitt einschließlich Zustand und Operationen.
5. Gewonnene Lokalität sowie wesentliche Kosten oder Einschränkungen.

Nutze passende Quellverweise. Halte das Format dem Befund angemessen;
erzeuge keine leeren Pflichtfelder.

Fasse Befunde mit derselben Ursache zusammen. Trenne bedingte
Möglichkeiten von ausreichend gestützten Empfehlungen.

Nenne bemerkenswerte bestehende Grenzen, wenn dies die Bewertung
erklärt. Erzeuge keinen vollständigen Katalog korrekter Stellen.

Keine feste Anzahl von Findings und kein Architektur-Score.
Ein Review ohne relevante Verbesserungsempfehlung ist ein gültiges
Ergebnis.