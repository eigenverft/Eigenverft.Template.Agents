# Statische Prüfung

Die Prüfung erfolgt mit `validate_bundle.py` ausschließlich lesend. Sie
validiert Metadaten, Hashes, unveränderte Kontrollblobs, gemeinsame Kerne,
abweichende Ansatzabschnitte, generische Skill-Inhalte, Markdown-Dateilinks,
den Turnierbaum und die 2×3-Ausführungseinheit. Sie führt weder Reviewer
noch Produktcode aus und behauptet keine praktische Wirksamkeit.

Die tatsächlich ausgegebenen Prüfergebnisse werden im Abschlussbericht
festgehalten. Dieses Dokument ersetzt keine Quellenbewertung echter Läufe.

Beim ersten Start wurde die Statusprüfung an die operative Fortführung
angepasst: vorbereitete Register müssen leer sein; ein belegter Dispatchfehler
ist ein zulässiger Betriebszustand. Kandidaten- und Regelprüfungen bleiben
unverändert. Der Validator startet keine Reviewer.
