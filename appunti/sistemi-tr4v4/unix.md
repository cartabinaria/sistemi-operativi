---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 23-10-2024 21:56:36
links:
  - "[[lecture-11102024092906|Lecture 11102024092906]]"
  - "[[lecture-16102024132343|Lecture 16102024132343]]"
  - "[[lecture-27022025151550|Lecture 27022025151550]]"
---
# Unix
---
## Storia
Le pietre miliari della storia di Unix sono raccolte qui:
- Apell, società telefonica, un lavoratore pensa che la comunicazione passerà per il digitale, e viene finanziato il progetto del sistema operativo Multix;
- Multix viene chiuso perché non porta guadagni immediati, così i ricercatori che si interessano al progetto partono in proprio da Multix per sviluppare Unix (nome in contrasto)
- capodanno 1970, istante 0 di tutti i tempi in Unix
- i sistemi operativi prima di Unix erano scritti in linguaggi di basso livello, che lavorassero in simbiosi con il processore: [[assembly|Assembly]], che non era comodo ed era diverso per ogni processore
- viene l'idea di sviluppare un linguaggio che consenta sia di interagire con l'hardware a basso livello, che di usare strutture di alto livello: [[c|C]]
- C ha una novità enorme: _fino ad allora i compilatori erano scritti in Assembly, mentre il compilatore C era scritto in C_[^1]!
- il grande riscontro e successo ottenuto da Unix è proprio dovuto a questo: poteva essere usato su macchine diversissime, proprio perché era scritto in C e con la tecnica del cross-compiling si poteva velocemente portare su altre macchine

## Architettura
![[unix-architettura.png]]

## Caratteristiche
### File system
E' una metafora del contenuto della memoria, che organizza i file ad [[albero|albero]]. In Unix la radice è la **root** `/`, che contiene directory standard del sistema:
- `boot` contiene i file del kernel per far partire il sistema operativo
- `dev` contiene i "file" dei devices (in realtà non sono file)
- `etc` contiene la configurazione del sistema
- `home` contiene le directory degli utenti
- `mnt` contiene i contenuti di una chiavetta attaccata alla macchina, è un punto di montaggio
- `root` è la home dell'amministratore
- `tmp` contiene i file temporanei di lavoro

_Il suffisso dei file serve solo per comodità_, almeno su Unix, quindi lui non sa niente perché ogni file è espresso come stringhe di byte.

### Processi
In Unix i [[processo|processi]] partono sempre con 3 flussi associati:
- _standard input_;
- _standard output_;
- _standard error_.

Sono tutti direzionabili.

## Referenze
[^1]: [[cross-compiler|cross compiler]]