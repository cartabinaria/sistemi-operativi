---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 23-10-2024 22:58:49
links:
  - "[[lecture-16102024132343|Lecture 16102024132343]]"
---
# GCC
---
## Caratteristiche
**GCC** non è solo un compilatore, ma invoca tante cose diverse:
- _preprocessore_ (interpreta i comandi che iniziano con `#`)
- _[[compilatore|compilatore]]_
- _ottimizzatore_
- _[[assembler|assemblatore]]_
- _[[linker|linker]]_

### Comandi
- `gcc -E` fa solo il preprocessore
- `gcc -S` fa preprocessore e compilatore
- `gcc -o hello_world hello_world.s` fa assemblatore e linker
- `gcc -c` fa tutto tranne il linker

### Osservazioni
- l'ottimizzatore può buttare via comandi del codice ritenuti inutili, a nostra insaputa!
- nota che per variabili dichiarate `volatile`, cioé che possono essere accedute da altri programmi durante l'esecuzione del processo associato, l'ottimizzatore non fa niente!
- il comando `nm` su un file eseguibile fa vedere la _symbol table_ del programma
- i processi o vengono uccisi o si uccidono, e `_start` è l'entry point per il linker, mentre `_exit` quella che lo uccide
- `_start` chiama il main del programma, e questo quando fa `return` fa tornare in mano il processo al linker che chiama la _system call_ 60, quella che uccide il processo
- per capire meglio guardare l'esempio del sito
- C è così flessibile che si può scrivere un _hello world_ senza usare alcuna libreria, sistemando nei registri i parametri della system call `write` (di codice 1), e chiamandola
- addirittura si può usare C senza usare le system call del sistema operativo... esempio di programma scritto in C che viene compilato usando un cross-compiler per una macchina diversa (semplicissima, un mini processore su una breadboard), che accende e spegne un led ogni 32768 cicli nulli

## Referenze