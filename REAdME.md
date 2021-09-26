# Implementierung einer Kemeny-Young Abstimmung

Das Skript implementiert einen einfachen Weg, eine Vielzahl von Stimmzetteln im Kemeny-Young-System auszuzählen.

**Einschränkungen**:

- Maximal 8 Kandidaten
- Stimmen müssen speziell formatiert werden:
  - in einer separaten Datei speichern
  - jede Zeile ist ein Stimmzettel (keine leeren Zeilen!)
  - Kandidaten werden über Zahlen beschrieben
  - jeder Stimmzettel muss alle möglichen Kandidaten enthalten
  - Präferenzlevel werden über Bidnestriche getrennt, bspw: "1-34-2"

**Benutzung**

Über Rscript kann die Datei geladen werden und die auszulesende Datei sowie die Anzahl der Kandidaten übergeben werden:
```
# Rscript kemeny_young_counting.R stimmzetteldatei anzahl_kandidaten
Rscript kemeny_young_counting.R stimmen.txt 8
```

**Warum nicht nur auf Bibliothek "votesys" aufbauend?**

[Votesys](https://cran.r-project.org/web/packages/votesys/index.html) implementiert verschiedene Zählungsalgorithmen, u.a. Kemeny-Young, ist jedoch nicht in der Lage, Stimmzettel zu verarbeiten, in denen Kandidaten das gleiche Präferenzlevel haben. Mein Ansatz löst dieses Problem, in dem eine eigene Methode zur Berechnung der Präferenzmatrix genutzt wird.
