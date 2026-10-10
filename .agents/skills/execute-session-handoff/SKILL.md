---
name: execute-session-handoff
description: Use when the user requests a full session transfer, chat-to-chat handoff, or continuation context for a fresh conversation, or provides such a handoff to resume later. Produce a complete, relevant snapshot of the known working and product state as Markdown directly in chat without new tool calls after the handoff request. Preserve decisions, completed and open work, and exact chat-native artifacts when needed. On receipt, acknowledge the transferred state and wait for a new task instead of automatically resuming work.
---

# Full Session Transfer

**Version:** 0.5
**Status:** Valid
**Canonical:** Yes

Erzeuge einen vollständigen Session-Handoff als Markdown direkt im Chat.

Der Full Session Transfer soll eine frische Chat-Session mit praktisch keinem vorherigen Gedächtnis in die Lage versetzen, die bisherige Arbeit korrekt zu verstehen und ohne unnötige Rekonstruktion sinnvoll fortzusetzen.

---

## Handoff Boundary

Die Anforderung eines Full Session Transfers beendet die aktive Arbeit dieser Session.

**Ab diesem Punkt keine neuen Toolcalls, MCP-Aufrufe, externen Prüfungen, Recherchen, Repository-/VM-/Runtime-Checks oder sonstigen Zustandsänderungen mehr ausführen.**

Erzeuge den Handoff ausschließlich aus dem bereits verfügbaren Session-Kontext.

Insbesondere nicht noch „zur Sicherheit“:

- aktuellen Git-Status prüfen;
- Runtime oder Deployment erneut abfragen;
- MCP-Tools aufrufen;
- Dateien oder VM-Zustände untersuchen;
- Web-Recherche starten;
- Tests ausführen;
- einen bereits bekannten Zustand erneut verifizieren.

Der User kann den Full Session Transfer gerade deshalb anfordern, weil die aktuelle Session bereits sehr lang, instabil oder nur noch eingeschränkt bedienbar ist. Die Handoff-Anforderung kann die letzte zuverlässig ausführbare Interaktion dieser Session sein.

Deshalb gilt:

> **Nach der Handoff-Anforderung keine neuen Erkenntnisse mehr erzeugen. Den vorhandenen Zustand retten.**

Wenn eine Information nicht mehr ausreichend vorhanden oder sicher rekonstruierbar ist, kennzeichne dies im Handoff, statt vor der Übergabe noch neue Aktionen auszuführen.

---

## Receiving Session / Resume Handshake

Wenn ein Full Session Transfer in einer neuen Session als Kontext übergeben wird, behandle ihn zunächst als **übernommenen Arbeitszustand**, nicht als Aufforderung, sofort neue Aktionen auszuführen.

Die neue Session soll zuerst knapp und eindeutig bestätigen:

- dass der Full Session Transfer vollständig gelesen wurde;
- dass der darin beschriebene Arbeits- und Produktzustand als Fortsetzungskontext übernommen wurde;
- dass bekannte offene, abgeschlossene, vertagte oder blockierte Punkte verstanden wurden, soweit sie im Handoff relevant dargestellt sind.

Danach **nicht automatisch mit der eigentlichen Arbeit beginnen**.

Insbesondere nicht allein aufgrund des Handoffs:

- Tools aufrufen;
- MCP-Verbindungen testen;
- Repository-Zustände prüfen;
- Dateien lesen;
- Runtime-/Deployment-Zustände verifizieren;
- Tests starten;
- Web-Recherche durchführen;
- externe Ressourcen verändern.

Der Handoff beschreibt einen **Snapshot des letzten bekannten Sessionzustands**. Er ist nicht automatisch eine Aussage darüber, dass alle darin erwähnten externen Ressourcen bereits im neuen Chat verfügbar, gestartet, aktualisiert oder unverändert sind.

Der User kann den Handoff bewusst schon vorbereiten und anschließend erst:

- Dienste neu starten;
- MCP-/Connector-Konfiguration aktualisieren;
- Deployments durchführen;
- Dateien oder Ressourcen verfügbar machen;
- andere vorbereitende Schritte erledigen.

### Optionaler Quick Check

Wenn für eine Fortsetzung externe Ressourcen relevant sind, darf die neue Session **einen kurzen Readiness-/Quick-Check anbieten**, aber nicht automatisch ausführen.

Der Quick Check soll nur prüfen, ob die für den Einstieg notwendigen Ressourcen grundsätzlich verfügbar sind.

Beispiele:

- ist die erwartete MCP-Verbindung grundsätzlich erreichbar;
- ist die erwartete Tool-Surface sichtbar;
- ist das relevante Repository oder der Connector grundsätzlich verfügbar;
- ist das notwendige Chat-Artefakt vorhanden.

Der Quick Check ist **keine vollständige Revalidierung des Handoffs**.

Nicht automatisch:

- jeden Commit erneut prüfen;
- alle Dateien erneut lesen;
- komplette Test-Suites starten;
- Logs vollständig untersuchen;
- Deployment oder Infrastruktur vollständig auditieren;
- jede Aussage aus dem Handoff erneut verifizieren.

Nach der Übernahme des Handoffs und einem gegebenenfalls angebotenen Quick Check auf den nächsten User-Auftrag warten.

---

## Grundprinzip

Übertrage **so viel relevanten Kontext wie sinnvoll möglich**.

Hoher relevanter Detailgrad ist wichtiger als Kürze.

Entferne:

- Wiederholungen;
- Gesprächslärm;
- rein administrative Zwischenkommunikation;
- überholte Zwischenstände ohne heutigen Nutzen.

Kürze aber keine Information weg, die einer neuen Session helfen kann:

- das aktuelle Arbeitsprodukt zu verstehen;
- Entscheidungen nachzuvollziehen;
- bereits geleistete Arbeit zu erkennen;
- Fehler oder Wiederholungen zu vermeiden;
- offene Arbeit korrekt fortzusetzen.

Der Full Session Transfer ist kein Formular, das mechanisch abgearbeitet werden soll.

Die Regeln und Themen in diesem Prompt sind ein **Denkrahmen**.

Entscheide anhand der konkreten Session selbst:

- was relevant ist;
- welcher Detailgrad erforderlich ist;
- welche Struktur am verständlichsten ist;
- welche Abschnitte sinnvoll sind;
- welche Kategorien weggelassen werden können.

Erzeuge keine leeren, künstlichen oder bedeutungslosen Abschnitte nur deshalb, weil sie hier erwähnt werden.

**Ziel ist nicht, möglichst viele Felder abzuhaken.**

Ziel ist, möglichst viel des tatsächlich wichtigen Sessionzustands korrekt und verständlich zu übertragen.

---

## Wann ein Full Session Transfer sinnvoll ist

Ein Full Session Transfer kann insbesondere sinnvoll oder notwendig sein, wenn:

- eine lange Session in einen neuen Chat überführt werden soll;
- UI, Kontextladung oder Fortsetzung einer sehr langen Session nicht mehr zuverlässig funktionieren;
- eine Session anderweitig in einen unzuverlässigen Zustand geraten ist;
- eine Tool-Integration, MCP-App, ein Connector oder ein anderes externes System aktualisiert wurde;
- sich verfügbare Tools oder deren Schnittstellen geändert haben;
- die laufende Chat-Session möglicherweise noch veraltete oder gecachte Informationen über externe Systeme besitzt;
- aus organisatorischen Gründen in einer neuen Session weitergearbeitet werden soll;
- ein bereits aus einem früheren Handoff entstandener Folgechat erneut übergeben werden muss.

Ein Full Session Transfer darf daher selbst wieder Ausgangspunkt für einen späteren Full Session Transfer sein.

---

## Was die neue Session verstehen können soll

Nach dem Lesen soll eine kompetente neue Session möglichst zuverlässig erkennen können:

- woran gearbeitet wird;
- welches Ziel verfolgt wird;
- was aktuell gültig ist;
- was das derzeitige Arbeitsprodukt ist;
- wie dieses Produkt oder System funktioniert;
- welcher Produktstand aktuell gilt;
- welche wichtigen Entscheidungen bereits getroffen wurden;
- warum nicht offensichtliche Entscheidungen getroffen wurden;
- was bereits erledigt wurde;
- was tatsächlich getestet oder verifiziert wurde;
- was noch offen ist;
- was bewusst nicht gemacht wurde;
- was derzeit blockiert ist;
- welche relevanten User-Anforderungen oder Einschränkungen gelten;
- welche Infrastruktur oder Umgebung für die Fortsetzung wichtig ist;
- welche Pitfalls bekannt sind;
- welche nächsten Schritte sinnvoll sind.

Nicht jede Session benötigt alle diese Informationen in gleicher Tiefe.

Gewichte sie nach ihrer Bedeutung für eine möglichst verlustarme Fortsetzung.

---

## Aktuelles Arbeitsprodukt erkennen

Bestimme ausdrücklich, was im Moment das eigentliche Arbeitsprodukt oder die eigentlichen Arbeitsprodukte sind.

Ein Arbeitsprodukt muss keine Datei, kein Repository und keine externe Ressource sein.

Es kann beispielsweise sein:

- Software oder ein Teil eines Softwareprojekts;
- Architektur;
- ein technisches Konzept;
- ein Prozess;
- eine Analyse;
- ein Plan;
- eine Recherche;
- ein Dokument;
- Markdown;
- ein Prompt;
- eine Spezifikation;
- eine Policy;
- ein Datenmodell;
- ein Schema;
- eine Checkliste;
- Code;
- ein Textentwurf;
- ein Vertrag oder Protokoll;
- ein vollständig im Chat entwickeltes Artefakt.

Der Handoff soll deutlich machen, **was tatsächlich weitergeführt werden soll**.

---

## Chat-basierte Produkte

Ein Produkt kann vollständig im Chat selbst existieren.

Beispiele:

- ein Markdown-Prompt;
- eine Spezifikation;
- eine Policy;
- ein Prozessmodell;
- eine Architekturdefinition;
- ein Schema;
- ein Text;
- ein Code-Artefakt;
- eine andere gemeinsam entwickelte strukturierte Definition.

Solche Produkte sind First-Class-Arbeitsprodukte und dürfen im Handoff nicht auf eine bloße Beschreibung reduziert werden.

### Produktidentität

Wenn es für die Zusammenarbeit sinnvoll ist, soll ein Chat-Produkt eine erkennbare Identität besitzen, beispielsweise:

```markdown
# Produktname

**Version:** 0.5
**Status:** Valid
**Canonical:** Yes
```

Version oder Status müssen nicht künstlich eingeführt werden, wenn sie keinen Nutzen haben.

Wenn ein Produkt jedoch bereits:

- einen Titel;
- eine Version;
- einen Status;
- eine andere Standkennung

besitzt, müssen diese Informationen im Handoff erhalten bleiben.

### Kanonischer Produktstand

Wenn das aktuelle Arbeitsprodukt selbst ein direkt übertragbares Chat-Artefakt ist und für die Fortsetzung benötigt wird, übernimm seinen **letzten gültigen kanonischen Stand**.

Eine reine Zusammenfassung reicht dann nicht.

Nicht nur:

> Wir arbeiten an einem Prompt für Session-Handoffs.

Sondern, wenn für die Fortsetzung erforderlich:

> Aktueller kanonischer Produktstand

gefolgt vom tatsächlichen aktuellen Produkt.

Die neue Session soll das Produkt nicht aus einer Beschreibung rekonstruieren müssen.

### Wann vollständige Übernahme nötig ist

Ein Chat-Artefakt sollte insbesondere vollständig übernommen werden, wenn:

- es ausschließlich im Chat existiert;
- keine andere zuverlässige Quelle dafür vorhanden ist;
- sein exakter Wortlaut oder seine Struktur Teil des Produkts ist;
- die neue Session direkt daran weiterarbeiten soll.

Ist das Produkt dagegen zuverlässig extern verfügbar, kann eine eindeutige Referenz zusammen mit:

- aktuellem Stand;
- relevanten Änderungen;
- offenen Punkten;
- nötigem Kontext

ausreichen, sofern dadurch keine für die Fortsetzung wichtige Information verloren geht.

### Diskussion ist nicht automatisch Produktzustand

Unterscheide zwischen:

- kanonischem Produktstand;
- diskutierten Ideen;
- vorgeschlagenen Änderungen;
- akzeptierten Änderungen;
- tatsächlich in eine vollständige Produktfassung integrierten Änderungen.

Eine Idee im Gespräch verändert den kanonischen Produktstand nicht automatisch.

### Full Repost

Wenn bei einem Chat-Produkt ein **Full Repost** verlangt wird, bedeutet dies:

> Gib den aktuellen vollständigen kanonischen Produktstand aus.

Dabei:

- Produktidentität erhalten;
- Version oder Stand korrekt wiedergeben;
- bereits integrierte Änderungen enthalten;
- noch nicht integrierte Diskussionen nicht stillschweigend einbauen;
- keine Mischung aus verschiedenen historischen Fassungen erzeugen.

Eine vollständige Produktfassung ist ein referenzierbarer Snapshot dieses Zustands.

---

## Produkt- und Systemverständnis erhalten

Wenn während der Session ein Produkt, Subsystem, Prozess, Protokoll, Sicherheitsmodell, Konzept oder eine Architektur beschrieben oder entwickelt wurde, soll der Handoff den **letzten relevanten gültigen Stand selbst erklären**.

Nicht nur:

> Wir haben System X besprochen.

Sondern ausreichend, damit eine neue Session versteht:

- was es ist;
- wozu es dient;
- wie es aktuell funktioniert;
- welche wichtigen Regeln gelten;
- welche Grenzen oder Annahmen bestehen;
- welche wesentlichen Entscheidungen feststehen.

Je zentraler dieses Produktverständnis für die weitere Arbeit ist, desto detaillierter soll es übertragen werden.

---

## User-Kontext erhalten

Übernimm relevante User-Informationen, die für die Fortsetzung tatsächlich wichtig sind.

Dazu können gehören:

- Ziele;
- Anforderungen;
- Entscheidungen;
- Präferenzen;
- Einschränkungen;
- Arbeitsweisen;
- Sicherheitsregeln;
- ausdrücklich gewünschte Vorgehensweisen;
- ausdrücklich ausgeschlossene Vorgehensweisen;
- Qualitätsanforderungen;
- bereits korrigierte Fehlinterpretationen.

Nicht jede beiläufige User-Aussage gehört in den Handoff.

Bewahre vor allem Informationen, deren Verlust dazu führen könnte, dass die neue Session:

- falsche Annahmen trifft;
- bereits geklärte Fragen erneut stellt;
- gegen User-Vorgaben arbeitet;
- bereits verworfene Ansätze wieder aufnimmt.

---

## Erkenntnisse aus der Session erhalten

Übernimm relevante Erkenntnisse, die erst während der Arbeit entstanden sind.

Zum Beispiel:

- technische Ursachen;
- Architekturentscheidungen;
- wichtige Beobachtungen;
- Plattformverhalten;
- bekannte Grenzen;
- verworfene Ansätze und deren relevante Gründe;
- korrigierte Fehlannahmen;
- wichtige Abhängigkeiten;
- besondere Betriebs- oder Tool-Eigenheiten.

Nicht jede gedankliche Zwischenstufe muss erhalten bleiben.

Bewahre das Ergebnis und das relevante **Warum**, wenn es für zukünftige Entscheidungen nützlich ist.

---

## Arbeitsstatus korrekt übertragen

Wenn relevant, unterscheide sauber zwischen Zuständen wie:

- besprochen;
- vorgeschlagen;
- entschieden;
- in einen kanonischen Produktstand übernommen;
- umgesetzt;
- getestet;
- committed;
- pushed;
- deployed;
- zur Laufzeit verifiziert.

Diese Zustände dürfen nicht miteinander verwechselt werden.

Beispielsweise bedeutet:

> committed

nicht automatisch:

> deployed

und:

> implementiert

nicht automatisch:

> erfolgreich getestet.

---

## Abgeschlossene, offene, vertagte und blockierte Arbeit

Der Handoff soll klar erkennen lassen, welche Arbeit:

- abgeschlossen;
- offen;
- bewusst vertagt;
- aktuell blockiert

ist, soweit diese Unterscheidung für die konkrete Session hilfreich ist.

Checklisten können dafür verwendet werden, beispielsweise:

### DONE

- [x] abgeschlossene Arbeit

### OPEN

- [ ] offene Arbeit

### DEFERRED

- [ ] bewusst vertagte Arbeit

### BLOCKED

- [ ] blockierte Arbeit mit Grund

Diese Kategorien sind **optional**.

Erzeuge nur die Kategorien, die für die konkrete Session tatsächlich nützlich sind.

Keine leeren Rubriken erzeugen.

Ein Punkt darf nicht gleichzeitig als abgeschlossen und offen dargestellt werden.

Bewusst vertagte Arbeit soll nicht wie ein vergessenes TODO aussehen.

---

## Infrastruktur und Umgebung

Übertrage technische oder organisatorische Infrastrukturinformationen, wenn sie für die Fortsetzung relevant sind.

Zum Beispiel:

- Repository;
- Projekt;
- Branch;
- Working Tree;
- wichtige Commits;
- relevante Dateien;
- Build-Zustand;
- Runtime-Version;
- Deployment-Zustand;
- Serverinstanz;
- Tooling;
- wichtige Verzeichnisse;
- spezielle Build-/Publish-Schritte;
- externe Systeme.

Nur relevante Informationen aufnehmen.

Wenn ein Arbeitsprodukt ausschließlich im Chat existiert, sage dies ausdrücklich.

Keine Datei, VM, Repository-Ablage oder Dokumentenablage erfinden, die nicht tatsächlich existiert.

---

## Validierung und Evidenz

Übertrage relevante Informationen darüber, was tatsächlich geprüft wurde.

Zum Beispiel:

- welche Tests liefen;
- welche Ergebnisse sie hatten;
- welche Messungen durchgeführt wurden;
- welcher Zustand zur Laufzeit verifiziert wurde;
- was lediglich aus Source Code bekannt ist;
- was nicht getestet wurde;
- was aufgrund eines Tool-, Cache-, Session- oder Infrastrukturproblems nicht mehr geprüft werden konnte.

Bei Chat-Produkten kann Validierung beispielsweise bedeuten:

- gemeinsam reviewed;
- vom User als Stand akzeptiert;
- gegen Anforderungen geprüft;
- noch nicht final bestätigt.

Unbekannte oder nicht verifizierte Punkte ausdrücklich als solche kennzeichnen.

Nicht raten.

---

## Confidence: Low

Verwende **kein allgemeines Confidence-Rating** und keine Kategorien wie `Good`, `Normal`, `High` oder ähnliche Labels.

Der normale Handoff benötigt kein Confidence-Label.

Nur wenn die Faktenlage für einen konkreten relevanten Bereich ungewöhnlich dünn, indirekt oder beschädigt ist, darf dieser Bereich gezielt mit:

> **Confidence: Low**

gekennzeichnet werden.

`Confidence: Low` ist eine Ausnahme und soll sparsam verwendet werden.

Es ist insbesondere sinnvoll, wenn beispielsweise:

- ältere Teile einer sehr langen Session nur noch verdichtet oder zusammengefasst im verfügbaren Kontext vorliegen;
- wesentliche Originaldetails offenbar nicht mehr direkt verfügbar sind;
- eine wichtige Aussage nur indirekt rekonstruiert werden kann;
- widersprüchliche Fragmente mit dem vorhandenen Kontext nicht zuverlässig aufgelöst werden können;
- der Handoff erkennen kann, dass bei einem relevanten Teil wahrscheinlich Details verloren gegangen sind.

Beispiel:

```markdown
### Frühere Architekturentscheidung

**Confidence: Low**

Die Kernaussage ist aus dem noch verfügbaren verdichteten Session-Kontext rekonstruierbar. Einzelne ursprüngliche Begründungsdetails könnten fehlen.
```

Nicht allein deshalb `Confidence: Low` verwenden, weil:

- eine Information nicht unmittelbar vor dem Handoff erneut geprüft wurde;
- ein Zustand älter ist;
- keine hundertprozentige Sicherheit möglich ist;
- eine Aussage aus normalem, ausreichend substantiellem Session-Kontext stammt.

Wenn nur ein Teil des Handoffs unsicher ist, markiere nur diesen Teil.

Den gesamten Handoff nicht unnötig abwerten.

---

## Handoff auf Handoff

Ein neuer Full Session Transfer darf einen früheren Full Session Transfer als Eingangskontext verwenden.

Der neue Transfer soll jedoch **konsolidieren**, nicht stapeln.

Das bedeutet:

- alte Handoffs nicht einfach vollständig aneinanderhängen;
- Informationen auf den neuesten gültigen Stand bringen;
- überholte Aussagen ersetzen;
- Widersprüche zugunsten neuerer oder besser verifizierter Informationen auflösen;
- relevante historische Informationen nur behalten, wenn sie den aktuellen Zustand erklären;
- bereits abgeschlossene Arbeit erhalten, wenn ihr Wissen für die Fortsetzung relevant bleibt;
- aktuelle Produktversionen korrekt übernehmen;
- ältere Produktversionen nicht versehentlich wieder zum aktuellen Stand machen;
- noch nicht integrierte Änderungsvorschläge weiterhin als solche kennzeichnen.

Der neueste Full Session Transfer muss für sich allein verständlich sein.

Eine neue Session soll nicht gezwungen sein, zuerst eine Kette älterer Handoffs zu lesen.

---

## Session-gebundener oder gecachter externer Zustand

Beachte, dass eine Chat-Session einen eigenen Zustand über externe Systeme besitzen kann, der nicht automatisch mit deren aktuellem Zustand identisch ist.

Dies kann beispielsweise betreffen:

- Tooldefinitionen;
- Connectoren;
- MCP-Tools;
- Session-gebundene Metadaten;
- gecachte Integrationsinformationen;
- andere externe Fähigkeiten.

Wenn sich ein externes System geändert hat, unterscheide zwischen:

1. aktuellem Zustand des externen Systems;
2. Zustand, den die bestehende Chat-Session tatsächlich kennt.

Eine laufende Session kann dadurch teilweise veraltet sein, obwohl das externe System bereits aktualisiert wurde.

Unveränderte Funktionen können weiterhin funktionieren, während geänderte Funktionen stale bleiben.

Dokumentiere solche Grenzen, wenn sie die Fortsetzung beeinflussen.

Nach Anforderung des Full Session Transfers jedoch **keine neuen externen Prüfungen mehr starten**, um diese Zustände nachträglich zu verifizieren.

---

## MCP- und OpenAI-Tool-Surface als konkreter Spezialfall

Bei MCP-/Tool-Surface-Änderungen kann insbesondere gelten:

- ein App- oder Server-Restart aktiviert die neue Implementierung;
- OpenAI-seitiges „Aktualisieren“ kann eine neue Tool-Surface laden;
- daraus folgt nicht zwingend, dass eine bereits laufende Chat-Session ihre zuvor gecachten Tooldefinitionen ebenfalls aktualisiert;
- unveränderte Tools können weiterhin funktionieren;
- geänderte oder neu hinzugekommene Tools können in der alten Session trotzdem stale sein;
- die alte Session ist dann kein zuverlässiger Acceptance-Test für genau diese Änderungen;
- ein frischer Chat kann für die endgültige Prüfung erforderlich sein.

Diesen Zustand nicht automatisch mit einem Serverfehler verwechseln.

Wenn diese Erkenntnisse bereits vor der Handoff-Anforderung im Session-Kontext vorhanden sind, im Handoff gegebenenfalls festhalten:

- welche Funktionen weiterhin geprüft werden konnten;
- welche wegen des Sessionzustands nicht zuverlässig prüfbar waren;
- welche Verifikation im neuen Chat nachgeholt werden sollte.

Nicht erst nach der Handoff-Anforderung neue MCP-Aufrufe starten, um diese Liste zu vervollständigen.

---

## Markdown- und Fence-Sicherheit bei Chat-Produkten

Wenn ein kanonischer Chat-Produktstand vollständig übertragen oder repostet wird, muss seine Markdown-Struktur erhalten bleiben.

Besondere Vorsicht gilt bei verschachtelten fenced code blocks.

### Äußerer Fence

Wenn eingebetteter Produkttext selbst Backtick-Fences enthält, verwende für eine umschließende Darstellung einen Fence, der länger ist als jede zusammenhängende Backtick-Sequenz im eingebetteten Inhalt.

Beispiel:

Wenn der eingebettete Inhalt Triple-Backticks besitzt:

```markdown
```text
innerer Block
```
```

kann die äußere Einbettung vier Backticks verwenden.

Enthält der eingebettete Inhalt selbst vier zusammenhängende Backticks, muss der äußere Fence entsprechend länger sein.

### Inhaltstreue

Bei kanonischen Produkt-Snapshots:

- interne Fences nicht beschädigen;
- Markdown-Struktur erhalten;
- Überschriften erhalten;
- semantisch relevante Formatierung nicht stillschweigend verändern;
- Zeichen nicht lediglich entfernen, weil die Einbettung dadurch einfacher wird.

Ein Full Repost soll als Produktstand zuverlässig reproduzierbar sein.

---

## Output Purity / kein unnötiger Handoff-Bootstrap

Der Full Session Transfer soll den relevanten Arbeitskontext enthalten, nicht die bloße Übergabezeremonie.

Die unmittelbar vorhergehende Kommunikation über:

- die Anforderung des Handoffs;
- die Bestätigung, dass er erzeugt wird;
- Kopierhinweise;
- administrative Erklärungen zur Übergabe;
- Meta-Sätze wie „hier ist dein Handoff“

gehört nicht automatisch in den Handoff.

Nicht übernehmen:

> Alles klar, ich erstelle jetzt den Handoff.

> Hier ist das Markdown zum Kopieren.

> Füge den folgenden Text in den neuen Chat ein.

Solche Sätze erklären nur den Übergabevorgang.

Eine dauerhafte Produkt- oder Arbeitsanforderung, die während dieser Meta-Diskussion entstanden ist, muss dagegen erhalten bleiben.

**Leitregel:**

> Übertrage den Arbeitskontext, nicht die Übergabezeremonie.

---

## Keine selbstreferenzielle Handoff-Kette

Ein Full Session Transfer soll nicht mit jeder Generation mehr Text darüber ansammeln, dass frühere Handoffs erzeugt wurden.

Nicht allein deshalb übernehmen:

- dass der Benutzer zuvor einen Handoff angefordert hat;
- dass ein Handoff kopiert wurde;
- dass danach ein weiterer Handoff angefordert wurde;
- dass eine Session nur zum Erzeugen eines weiteren Handoffs diente.

Übernimm daraus nur die Informationen, die für die eigentliche Arbeit relevant geworden sind.

Ausnahme:

Wenn der Handoff-Prozess selbst das aktuelle Arbeitsprodukt ist, gehört dessen kanonischer Produktstand selbstverständlich zum Handoff.

Auch dann ist die bloße Übergabezeremonie nicht automatisch Teil des Produkts.

---

## Weitere Pitfalls

### Keine Kontextlawine

Vollständigkeit bedeutet nicht, den gesamten Chat wortwörtlich wiederzugeben.

Verdichte Wiederholungen.

Bewahre Information, Entscheidungen und Produktzustand statt Gesprächslärm.

### Nicht zu aggressiv kürzen

Kompaktheit ist kein Selbstzweck.

Wenn eine Information der neuen Session wahrscheinlich bei:

- Verständnis;
- Rekonstruktion;
- Entscheidungsfindung;
- Fehlervermeidung;
- Fortsetzung

hilft, soll sie im Zweifel erhalten bleiben.

### Keine starre Berichtsschablone

Die in diesem Prompt genannten Themen sind Prüfpunkte, keine verpflichtende Überschriftenliste.

Eine technische Debugging-Session darf anders strukturiert sein als:

- ein Schreibprojekt;
- eine Produktentwicklung;
- eine Recherche;
- ein persönlicher Plan;
- ein Chat-nativer Prompt.

Wähle die Struktur, die den konkreten Sessionzustand am klarsten transportiert.

### Kein Chat-Artefakt verlieren

Wenn das eigentliche Produkt direkt im Chat existiert und keine andere zuverlässige Quelle besitzt, darf der Handoff es nicht auf eine Zusammenfassung reduzieren.

### Keine erfundene externe Ablage

Wenn ein Produkt nur im Chat existiert, keine Datei, VM, Datenbank, Repository-Ablage oder Dokumentenablage behaupten, die nicht existiert.

### Keine Produktidentität verlieren

Titel, Version oder Standkennungen eines relevanten Chat-Produkts erhalten, sofern sie existieren.

### Keine diskutierten Änderungen als integriert behandeln

Diskussion, Vorschlag, Entscheidung und kanonischer Produktstand sind unterschiedliche Zustände.

### Keine falsche Aktualität

Unterscheide, wenn relevant, zwischen:

- historisch;
- früher angenommen;
- später korrigiert;
- aktuell im Produkt;
- aktuell im Repository;
- deployed;
- zur Laufzeit verifiziert.

### Keine verlorenen Gründe

Wenn eine Entscheidung ohne ihren Grund später leicht falsch rückgängig gemacht werden könnte, das relevante Warum mit übertragen.

### Keine unnötige Wiederholung abgeschlossener Arbeit

Eine neue Session soll fortsetzen und nicht bereits sauber abgeschlossene Arbeit erneut durchführen.

### Keine sensiblen Werte unnötig vervielfältigen

Standardmäßig keine unnötige Übernahme von:

- Passwörtern;
- Tokens;
- privaten Schlüsseln;
- Capability-Werten;
- anderen sensitiven Zugangswerten.

Ihre Rolle und ihr Zustand können beschrieben werden, ohne den konkreten Wert zu kopieren.

### Keine stillen Lücken

Wichtige unbekannte oder nicht verifizierte Informationen ausdrücklich kennzeichnen.

Nicht plausibel klingende Details erfinden.

---

## Ausgabeformat

Wenn dieser Prompt zur Erzeugung eines Full Session Transfers verwendet wird, antworte **ausschließlich mit dem eigentlichen Handoff-Markdown direkt im Chat**.

Kein zusätzlicher Text davor.

Kein zusätzlicher Text danach.

Keine Bestätigung.

Keine Gebrauchsanweisung.

Nicht als:

- Datei;
- Download;
- Python-Artefakt;
- VM-Datei;
- extern gespeichertes Dokument

erzeugen, sofern der Benutzer nicht ausdrücklich etwas anderes verlangt.

Der Markdown-Text im Chat selbst ist das Übergabe-Artefakt.

Der erste ausgegebene Inhalt gehört bereits zum Handoff.

Der letzte ausgegebene Inhalt gehört ebenfalls zum Handoff.

---

## Qualitätsregel

Der Full Session Transfer soll einen **hohen relevanten Detailgrad** besitzen und gleichzeitig unnötige Redundanz vermeiden.

Beurteile Relevanz aus Sicht einer kompetenten neuen Session ohne vorheriges Gedächtnis.

Der entscheidende Qualitätstest ist:

> Kann eine neue kompetente Session allein anhand dieses Transfers verstehen, was aktuell wichtig ist, den tatsächlichen Arbeits- und Produktzustand rekonstruieren, bereits geleistete Arbeit respektieren und ohne unnötige Rückfragen oder Wiederholungen sinnvoll fortfahren?

Wenn ein Chat-basiertes Produkt weitergeführt wird, gilt zusätzlich:

> Kann die neue Session eindeutig erkennen, welches Produkt gemeint ist, welcher Stand davon aktuell gilt und – wenn nötig – dessen kanonischen Inhalt unmittelbar weiterverwenden?