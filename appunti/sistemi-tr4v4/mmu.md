---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 16:52:52
links:
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# MMU
---
## Introduzione
> La **MMU** (**Memory Management Unit**) e' un _dispositivo hardware che si occupa di tradurre gli indirizzi logici in indirizzi fisici per l'accesso alla [[memorie|memoria]]_.

## Tipologie
### Registro di rilocazione
La MMU in questo caso non fa altro che sommare un offset ad ogni indirizzo logico: se il valore del _registro di rilocazione_ e' $R$, allora lo [[indirizzo-logico|spazio logico]] $0, \cdots, \max$ viene tradotto nello [[indirizzo-fisico|spazio fisico]] $R, \cdots, R + \max$.

![[registro-rilocazione.png]]

<u>Curiosita'</u>: nei processori Intel 8086 esistono 4 registri base per il calcolo degli indirizzi (CS, DS, SS, ES).

### Registro limite
La MMU in questo caso pone prima del registro di rilocazione un _registro limite_, che _filtra gli indirizzi logici su un certo insieme di indirizzi "consentiti"_, scatenando una [[trap|trap]] in caso di indirizzo non valido.

![[registro-limite-e-rilocazione.png]]

E' con questo registro che la MMU fornisce i **[[protezione-hardware|meccanismi di protezione]] della memoria**!

## Referenze