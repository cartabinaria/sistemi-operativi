---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 25-09-2023 18:46:38
links:
  - "[[lecture-25092023130405|Lecture 25092023130405]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# HD
---
## Definizione
> Gli **HD** (_Hard Disk_) sono **dispositivi elettro-meccanici** per la conservazione di informazioni sotto forma _magnetica_.

Sono molto più lenti della [[ram|RAM]], ma in grado di salvare in maniera persistente una ben più grande quantità di dati.

L'**accesso ai dati e' diretto**, non sequenziale.

## Composizione
- **piatto** - disco magnetico, rivestito da uno strato di materiale magnetico
- **testina** - magnetizza e legge lo stato di magnetizzazione della superficie del disco
- **traccia** (o **cilindro**) - sequenza circolare di bit
- **settore** - porzione di traccia che contiene una quantità prefissata di bit (uguale per tutti i settori)

Per accedervi il [[device-controller|controller]] espone i metodi:
- `READ(head, sector)`
- `WRITE(head, sector)`
- `SEEK(cylinder)` - la piu' costosa, consiste nello spostare fisicamente il pettine di testine da un cilindro a un altro;

## Parametri
I parametri fondamentali di un disco sono:
- $r$: la _velocità di rotazione_, espressa in rpm (revolutions per minute);
- $T_{s}$: il _tempo di seek_, ovvero il tempo medio necessario affinchè la testina si sposti sulla traccia desiderata;
- $V_{r}$: la _velocità di trasferimento_, espressa in byte al secondo;

Quindi si definiscono:
- **tempo di accesso**: tempo necessario per leggere un settore del disco, composto da tempo di seek, ritardo rotazionale e tempo di trasferimento;
- **ritardo rotazionale**: tempo medio necessario affinchè il settore desiderato arrivi sotto la testina --> $\frac{1}{2r}$;
- **transfer time**: dipende dalla quantità di dati $b$ da leggere (supponendo che siano contigui sulla stessa traccia) --> $\frac{b}{V_{r}}$.

## Referenze
- [[disk-scheduling|Disk scheduling]]