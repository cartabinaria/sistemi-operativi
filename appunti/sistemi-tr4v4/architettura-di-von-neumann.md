---
tags:
  - "#category/note"
  - "#status/finished"
  - topic/programmazione
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 18-09-2023 22:04:21
links:
  - "[[lecture-18092023150410|Lecture 18092023150410]]"
  - "[[lecture-20092023151652|Lecture 20092023151652]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Architettura di von Neumann
---
## Introduzione
L'architettura di von Neumann è **bus-oriented** (_orientata a bus_), il che significa che a collegare le differenti componenti del calcolatore sono dei fili.

In particolare nell'architettura standard i bus si dividono in:
- _bus indirizzi_ - unidirezionali (CPU --> RAM)
- _bus dati_ - bidirezionali (CPU <--> RAM)
- _bus controllo_ - unidirezionali (CPU --> RAM)

Componenti principali:
- [[i-o|I-O]]
- [[ram|RAM]]
- [[cpu|CPU]]
- memoria secondaria (_fissa_), che memorizza i programmi non in esecuzione

A fare da **arbitro del bus** verificando e gestendo gli accessi è la CPU stessa: affinché una periferica voglia accedere al bus, deve avere il permesso del processore.

![[architettura-von-neumann2.png]]

## Prefissi per ordini di grandezza
Esistono due principali prefissi utilizzati per misurare la velocità di un elaboratore. In particolare:
- **MIPS**: milioni di operazioni per secondo
- **GFLOPS**: miliardi di operazioni _floating-point_[^1] per secondo

### Tipi di elaboratori
Per dare un'idea delle potenze degli attuali tipologie di computer comparate:
- computer "usa e getta" --> alcuni MIPS
- sistema **embedded** --> 1-100 MIPS
- smartphone e tablet --> 10K-100K MIPS
- console da gioco --> 200-1000 GFLOPS
- PC --> 100-1000 GFLOPS
- server e workstation --> 200 GFLOPS-20 TFLOPS
- [[cluster|cluster]] --> 500 GFLOPS-50 TFLOPS
- supercalcolatore --> 500 TFLOPS-500 PFLOPS

## Referenze
[^1]: operazioni in [[codifica-floating-point|virgola mobile]]