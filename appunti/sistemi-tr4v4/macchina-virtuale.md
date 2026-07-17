---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 18:02:33
links:
  - "[[lecture-28022025091715|Lecture 28022025091715]]"
---
# Macchina virtuale
---
## Introduzione
> Una **macchina virtuale** e' un'_astrazione dell'hardware_.

E' un approccio diverso al multitasking: invece di creare l'illusione di molteplici processi che hanno la propria [[cpu|CPU]] e la propria [[memorie|memoria]], si crea l'astrazione di un'intera macchina.

![[virtual-machine.png]]

<u>Attenzione</u>: non e' da confondere con un'emulazione dell'hardware. Altrimenti consisterebbe in una traduzione delle istruzioni.

### Vantaggi
Attraverso le macchine virtuale si possono far coesistere piu' [[sistema-operativo|sistemi operativi]] differenti; si possono far funzionare sistemi operativi monotask in un sistema multitask ([[multiprocessing|multiprocessing]]) in modo sicuro; infine possono essere emulate architetture hardware differenti.

### Svantaggi
Sono una soluzione inefficiente, perche' ogni istruzione e' virtualizzata; inoltre e' impossibile condividere le risorse tra le macchine virtuali.

## Tipologie
Le macchine virtuali possono essere:
- _a livello processo_ --> la VM e' un processo stesso, che consente di virtualizzare l'hardware;
- _a livello sistema_ --> la VM e' a piu' basso livello, a diretto contatto con l'hardware, e permette di partizionare l'hardware tra le tante macchine virtuali.

![[virtual-machines-tipologie.png]]

## Referenze