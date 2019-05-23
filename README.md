# shell-spielereien

Verschiedene kleine Spielereien für die UNIX-Shell.

### files.sh
Akzeptiert eine beliebige Liste von Verzeichnissen und gibt eine Zusammenfassung der darin enthaltenen Dateien.

Einmal eine Zusammenfassung der gefundenen Dateitypen (`directory`, `regular file`, `symlink`,...) mitsamt der Gesamtzahl und Gesamtgröße und dann nochmal das gleiche für die gefundenen Dateiendungen (`.txt`, `.png`, `.pdf`,...).

![Ausgabe von files.sh](https://raw.githubusercontent.com/datenbauer/shell-spielereien/master/files-sh_demo.png)

### palindrome.sh
Liest die Standardeingabe zeilenweise und gibt ein Wort wieder aus, falls es sich um ein Palindrom handelt.

Das Skript ist POSIX-konform; es werden ausschließlich shell-builtins verwendet.

Die Eingabe kann interaktiv im Terminal erfolgen oder beispielsweise aus einer Datei:

```shell
$ ./palindrome.sh < eingabedatei.txt
```

### pdf2txt.sh
Wandelt eine pdf-Datei in eine Textdatei um. Nützlich für Scans alter Bücher, wie man sie beispielsweise auf der Seite [archive.org] reichlich finden kann. Die Digitalisierung solcher Bücher wäre händisch viel zu aufwändig und die manchmal schon eingebettete OCR ist in der Hinsicht praktisch keine Hilfe.

Das Skript setzt die Programme `pdfinfo`, `pdftoppm` und `tesseract-ocr` voraus. Für Tesseract sollten noch die gewünschten Sprachpakete zusätzlich heruntergeladen werden. Unter Ubuntu sollte folgender Befehl reichen:
```
$ sudo apt install poppler-utils tesseract-ocr
```

Das Sprachpaket für Französisch kann so installiert werden:
```
$ sudo apt install tesseract-ocr-fra
```
Eine vollständige Liste aller verfügbaren sprachen ist mit `tesseract --list-langs` einsehbar.