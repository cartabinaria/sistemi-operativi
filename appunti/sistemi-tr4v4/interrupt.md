---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 05-11-2023 22:50:47
links:
  - "[[lecture-02112023130607|Lecture 02112023130607]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Interrupt
---
## Definizione
> Gli **interrupt** interrompono il programma in esecuzione e trasferiscono il controllo momentaneamente a un **gestore di interrupt** ([[isr|ISR]], _Interrupt Service Routine_).
> Formalmente sono un _meccanismo che permette l'interruzione del normale [[ciclo-di-fetch-decode-execute|ciclo di esecuzione]] della [[cpu|CPU]]_.

### Differenza con trap
La differenza fondamentale tra _interrupt_ e _[[trap|trap]]_ sta nel fatto che queste ultime sono **sincrone**, e quindi viene scatenata ogni volta allo stesso modo da un programma che "triggera" gli eventi scatenanti; mentre gli interrupt sono **asincroni**, in quanto scatenati da altri dispositivi che sono indipendenti dal programma in esecuzione, come gli [[i-o|I-O]].

Formalmente **le trap sono interrupt software**: sono causati dal programma in esecuzione, come errori di divisione per 0, problemi di indirizzamento ([[page-fault|page fault]]), o le stesse [[system-call|system call]].

Gli **interrupt normali, invece, sono hardware**: eventi asincroni scatenati da, per esempio, dispositivo di I-O, o dalla scadenza dell'[[interval-timer|interval timer]], ecc... (ad ogni modo scatenati dai [[device-controller|controller]] dei dispositivi).

<u>Nota bene</u>: **quando un processo richiede un'operazione di I/O NON scatena un interrupt**, ma viene interrotto e rieseguito quando il device selezionato produce l'interrupt di termine dell'operazione.

## Vantaggi
L'utilizzo degli interrupt permette di evitare il fenomeno del _busy waiting_, ovvero della continua esecuzione di istruzioni volte a verificare l'accadimento di un certo evento[^1]: _è il dispositivo stesso che, scatenato un certo evento, interrompe il programma in esecuzione e prende il controllo_.

Di fatto, quindi, aumentano l'efficienza del calcolatore, permettendo al [[sistema-operativo|sistema operativo]] di intervenire durante l'esecuzione di un programma.

## Tipologie
Non tutti gli interrupt possono interrompere, senza un minimo di criterio, i processi in esecuzione sulla CPU. Per questo si dividono principalmente in:
- **interrupt mascherabili** --> per cui il [[sistema-operativo|sistema operativo]] sceglie, a seconda della loro _priorità_, se interrompere o meno il processo in esecuzione
- **interrupt non-mascherabili** --> per cui a prescindere dal processo in esecuzione il sistema operativo passa il controllo all'interrupt

In generale, però, si definisce una _gerarchia di interrupt_ che stabilisce quali interrupt si possono interrompere a seconda di una _scala di priorità_:
> Un interrupt _più importante_ può interrompere il gestore di un interrupt _meno importante_.

![[gerarchie-interrupt.png]]

## Referenze
- [[gestione-degli-interrupt|Gestione degli interrupt]]

[^1]: anche detto [[polling|polling]]