---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 23-10-2024 22:10:48
links:
  - "[[lecture-11102024092906|Lecture 11102024092906]]"
---
# Cross compiler
---
## Definizione
> Un **cross compiler** è un _[[compilatore|compilatore]] che compila codice che può essere eseguito su altre macchine_, consentendo il _cross compiling_.

## Idea
Supponiamo di essere in possesso di un compilatore $C_{L_{1}, L_{A_{0}}}^{L_{A_{0}}}$ scritto nel linguaggio $L_{A_{0}}$ ([[assembly|assembly]]) della [[macchina-astratta|macchina]] $M_{A}$. Vogliamo ottenere $C_{L_{1}, L_{B_{0}}}^{L_{B_{0}}}$, ossia un compilatore scritto nel linguaggio $L_{B_{0}}$ della macchina $M_{B}$ che traduca da $L_{1}$ a $L_{B_{0}}$. Supponiamo di avere $C_{L_{1}, L_{B_{0}}}^{L_{1}}$, ossia un compilatore di $L_{1}$ in $L_{B_{0}}$ scritto nello stesso $L_{1}$.

Allora possiamo sfruttare la seguente sequenza di passaggi per ottenere $C_{L_{1}, L_{B_{0}}}^{L_{B_{0}}}$:
$$C_{L_{1}, L_{A_{0}}}^{L_{A_{0}}}(C_{L_{1}, L_{B_{0}}}^{L_{1}}) = C_{L_{1}, L_{B_{0}}}^{L_{A_{0}}}$$

$$C_{L_{1}, L_{B_{0}}}^{L_{A_{0}}}(C_{L_{1}, L_{B_{0}}}^{L_{1}}) = C_{L_{1}, L_{B_{0}}}^{L_{B_{0}}}$$

<u>Nota bene</u>: almeno il compilatore iniziale $C_{L_{1}, L_{A_{0}}}^{L_{A_{0}}}$ scritto in $L_{A_{0}}$ deve esistere.

## Referenze