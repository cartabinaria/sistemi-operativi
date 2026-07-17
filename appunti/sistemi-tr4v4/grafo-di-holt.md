---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 25-03-2025 18:03:57
links:
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Grafo di Holt
---
## Introduzione
> Il **grafo di Holt** e' un [[grafo|grafo]] _[[grafo-orientato|orientato]] e bipartito_ (nodi dello stesso sottoinsieme non sono collegati da alcun arco), tale per cui:
> - gli archi _risorsa -> processo_ indicano l'assegnazione della risorsa al processo;
> - gli archi _processo -> risorsa_ indicano la richiesta della risorsa da parte del processo.

## Notazioni
Nel caso base, il grafo si presenta quindi in questo modo:
![[grafo-di-holt.png]]

Se consideriamo invece classi di risorse contenenti piu' istanze, allora appare come:
![[grafo-di-holt-classi-istanze.png]]

<u>Nota bene</u>: non si rappresentano gli archi _processo -> risorsa_ se la richiesta puo' essere soddisfatta da un assegnazione dell'istanza!

Formalmente rappresentiamo pero' i grafi di Holt con
- sugli archi la _molteplicita' della richiesta o dell'assegnazione_;
- sulle classi di risorse il _numero di risorse non ancora assegnate_.

![[grafo-di-holt-reale.png]]

## Riducibilita'
> Un grafo di Holt e' **riducibile** se _esiste almeno un nodo processo con solo archi entranti_.

In tal caso significa che a quel processo sono state assegnate le risorse, per cui _ridurre il grafo significa per quel nodo eliminare tutti gli archi e riassegnare le risorse liberate ai processi richiedenti_. Infatti un nodo processo con solo archi entranti prima o poi terminera', perche' ha tutte le risorse di cui ha bisogno.
![[grafo-di-holt-riducibilita.png]]

## Referenze