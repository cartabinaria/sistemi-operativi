---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 24-10-2024 00:07:26
links:
  - "[[lecture-17102024091631|Lecture 17102024091631]]"
---
# Sezione critica
---
## Introduzione
Sapendo che le sequenze di istruzione non vengono eseguite come [[azione-atomica|azioni atomiche]], **l'obiettivo è di ottenere un meccanismo che consenta solo a certe sequenze di essere considerate come tali**.

## Definizione
> Si definisce **sezione critica** (o **critical section**, **CS**) la _parte di un [[programma|programma]] che utilizza una o più risorse condivise_.

Si vuole fare in modo che durante l'esecuzione di sezioni critiche vengano garantiti:
- _[[mutua-esclusione|mutua esclusione]]_, eseguendole come se fossero atomiche;
- _assenza di [[deadlock|deadlock]] e di [[starvation|starvation]]_;
- _assenza di attese non necessarie_.

Questo prende il nome di [[problema-della-sezione-critica|problema della sezione critica]].

### Sintassi
Indichiamo una sezione critica con la seguente [[sintassi|sintassi]]:
`[enter cs] statement critico [exit cs]`

Abbiamo bisogno di indicare al [[sistema-operativo|sistema operativo]] quali sezioni sono critiche e quali non lo sono perché lui non è in grado di riconoscerle. Ci _permette così di evitare errori da [[race-condition|race condition]] e di consentire un parallelismo (reale o apparente) sulle sezioni non critiche_.

## Referenze