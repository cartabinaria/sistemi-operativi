---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 03-05-2025 18:07:38
links:
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# TLB
---
## Introduzione
> La **TLB** (_Translation Lookaside Buffer_) è un _insieme di registri associativi ad alta velocita'_, in cui ogni registro e' composto da una chiave e un valore (fondamentalmente un [[tabella-hash|hashmap]]) usata nella [[paginazione|paginazione]] come _tabella delle pagine_.
> Si tratta di una [[cache|cache]].

L'hardware della TLB e' costoso, di fatto la dimensione e' nell'ordine degli 8-2048 registri.

## Funzionamento
Quando viene richiesta la ricerca di una pagina (chiave), in un solo ciclo di [[clock|clock]] questa viene confrontata con tutte le chiavi del buffer. Puo' avvenire che:
- la pagina sia presente (_TLB hit_) --> in questo caso viene restituito il frame associato (valore);
- la pagina non sia presente (_TLB miss_) --> in questo caso l'associazione viene cercata nella tabella delle pagine in memoria, e successivamente inserita nel buffer.

![[tlb.png]]

Come ogni memoria cache, il meccanismo della TLB si basa sul _principio di localita'_ (temporale e spaziale).

## Referenze