---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 18:36:36
links:
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
---
# PCB
---
## Introduzione
> Un **PCB** (**Process Control Block**) e' una [[struttura-dati|struttura dati]] contenente le informazioni che identificano un [[processo|processo]], in particolare:
> - _identificazione del processo_
> 	- `pid`, che potrebbe essere l'indice dell'array della tabella, ma questo causerebbe il problema della reincarnazione, quindi e' un numero progressivo;
> 	- identificatore del padre, o di processi correlati;
> 	- identificatore dell'utente che ha richiesto la sua esecuzione;
> - _stato del processo_
> 	- [[registro-registri-generali|registri generali]] del [[cpu|processore]];
> 	- [[registro-registri-speciali|registri speciali]] del processore ([[pc|PC]] e [[psw|PSW]]);
> 	- informazioni di [[scheduling|scheduling]] varie;
> - _controllo del processo_
> 	- stato del processo;
> 	- [[gestione-della-memoria|gestione della memoria]];
> 	- accounting (importanti per misurare le prestazioni!);
> 	- relative alle risorse;
> 	- priorita' (per le politiche di scheduling);
> 	- interprocess comunication ([[ipc|IPC]]);

## Referenze