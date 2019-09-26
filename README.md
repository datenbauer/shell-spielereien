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
Ein Skript, das OCR einsetzt, um bildlastige pdf-Dateien in reine Textdateien umzuwandeln.  Nützlich für Scans alter Bücher, wie man sie beispielsweise auf der Seite archive.org reichlich finden kann. Die Digitalisierung solcher Bücher wäre händisch viel zu aufwändig und die manchmal schon eingebettete OCR ist in der Hinsicht praktisch keine Hilfe.

Das Skript setzt die Programme `pdfinfo`, `pdftoppm` und `tesseract-ocr` voraus. Für Tesseract sollten noch die gewünschten Sprachpakete zusätzlich heruntergeladen werden. Die Installation der Abhängigkeiten unter Ubuntu:
```
$ sudo apt install poppler-utils tesseract-ocr
```

Das Sprachpaket für bspw. Französisch kann so installiert werden:
```
$ sudo apt install tesseract-ocr-fra
```
Eine vollständige Liste aller verfügbaren sprachen ist mit `tesseract --list-langs` einsehbar.

### ufpb.sh
Ein animierter Fortschrittsbalken (*"user friendly progress bar"*), der einfach parametrisierbar ist und so mit praktisch keinem Aufwand in eigene Projekte einzubinden ist.

So geht's:
1. Code einbinden
2. Breite der Leiste festlegen (ist überall möglich, auch dynamisch). Bsp.:
```
ufpb_size=20      # Leiste ist 20 Zeichen breit
```
3. Ermitteln, wie viele Einheiten abgearbeitet werden müssen (bspw. wieviele Bytes kopiert werden müssen, wieviele Dateien verarbeitet werden o.Ä.). Bsp.:
```
ufpb_maximum=10254      # Programm arbeitet 10254 Dinge ab
```
4. Die Leiste über den Fortschritt informieren:
```
ufpb_set 435            # 435 Einheiten sind schon fertig
```
5. Nachdem die Leiste intern auf dem neuesten Stand ist, muss sie noch auf den Bildschirm gedruckt werden:
```
ufpb_draw               # Da ist sie :)
```

![Demo](https://raw.githubusercontent.com/datenbauer/shell-spielereien/master/ufpb.sh_demo.gif)
