---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 19:27:51
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# RAID 1
---
## Introduzione
> Il **RAID 1** è una configurazione di [[raid|RAID]] che prevede la sola _duplicazione_ (_mirroring_) dei dati su due insiemi indipendenti di dischi. Come per il [[raid-0|RAID 0]], ogni insieme di dischi e' gestito con striping, ma lo strip viene scritto su due dischi diversi in modo da garantire la ridondanza dei dati.

Il costo per unita' di memorizzazione chiaramente raddoppia, ma il RAID 1 e' in grado di garantire una buona tolleranza ai guasti e una buona velocita' di lettura. In caso di guasto di un disco, i dati possono essere recuperati dall'altro disco (appartenente al mirror).

![[raid-1.png]]

<u>Attenzione</u>: la **ridondanza e' manutenuta fin tanto che si rompono due dischi appartenenti allo stesso mirror**!

## Referenze