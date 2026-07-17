---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 25-09-2023 18:57:06
links:
  - "[[lecture-25092023130405|Lecture 25092023130405]]"
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# RAID
---
## Introduzione
> Per **RAID** (_Redundant Array of Independent Disks_) si intende un insieme di tecniche e metodologie utilizzate per la _gestione di più memorie secondarie in parallelo_.

Consiste nella pratica in 7 schemi diversi di organizzazione dei dati su più dischi, che possono essere sia [[hd|HD]] che [[ssd|SSD]].

Il RAID nasce da un problema: i processori sono sempre piu' veloci[^1], mentre i dischi no.

## Caratteristiche
L'array di dischi viene virtualizzato e visto dal [[sistema-operativo|sistema operativo]] come un unico disco logico. I dati sono solitamente distribuiti tra i dischi fisici per:
- **aumentare la velocità di accesso**;
- **aumentare la sicurezza dei dati**.

Per consentire cio', ogni schema RAID non prevede il salvataggio dei dati in modo sequenziale tra i dischi, ma distribuito in modo da consentire l'_accesso sequenziale_ e l'eventuale _ricostruzione dei dati_ in caso di guasto di un disco.

Sappiamo infatti dalla [[probabilita|probabilita']], che **piu' dischi ci sono, più è probabile che uno di essi si rompa**, guastando l'intera memoria secondaria. Il RAID quindi non si deve occupare solo di velocizzare l'accesso, ma anche di implementare meccanismi di _ridondanza o recovery dei dati_, come la **parita'**.

<u>Nota bene</u>: e' importante che affinche' le performance migliorino complessivamente, il bus deve tollerare la maggiore velocità di accesso. Allo stesso tempo il sistema operativo deve presentare al disco logico richieste che possano essere soddisfatte in modo efficiente:
- _richieste di lettura di grandi quantità di dati sequenziali_;
- _gran numero di richieste indipendenti_.

## Tipologie
- [[raid-0|RAID 0]]
- [[raid-1|RAID 1]]
- RAID 2
- RAID 3
- [[raid-4|RAID 4]]
- [[raid-5|RAID 5]]
- [[raid-6|RAID 6]]
- RAID 10

## Referenze

[^1]: [[legge-di-moore|legge di Moore]]
