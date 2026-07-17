---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 19:32:26
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# RAID 4
---
## Introduzione
> Il **RAID 4** è una configurazione di [[raid|RAID]] che utilizza striping con strip molto grandi, e poi un unico disco che contiene gli strip di parita'.

Gli strip di parita' sono calcolati facendo lo [[xor|XOR]] bit-a-bit di tutti gli strip dei dischi corrispondenti. Questi **consentono di recuperare i dati di uno strip corrispondente in caso di guasto**: basta fare lo XOR tra tutti i restanti strip.

![[raid-4.png]]

### Lettura
Per leggere e' ottimo, perche' si sfrutta lo striping al massimo.

### Scrittura
Per scrivere invece e' stupido, perche' **ogni volta che si scrive un blocco bisogna ricalcolare il blocco di parita' e scriverlo**.

In realta' non c'e' bisogno di tutti gli strip per poter calcolare il blocco di parita'. Supponiamo di voler cambiare lo strip 1, allora dovremmo eseguire:
$$S'_{4}(i) = S_{0}(i) \oplus S'_{1}(i) \oplus S_{2}(i) \oplus S_{3}(i)$$
dove $S'_{4}(i)$ e' il blocco di parita' aggiornato, $S'_{1}(i)$ e' il blocco aggiornato, mentre gli altri rimangono invariati.

Possiamo pero' notare che
$$S'_{4}(i) = S_{0}(i) \oplus S'_{1}(i) \oplus S_{2}(i) \oplus S_{3}(i) = S_{0}(i) \oplus S'_{1}(i) \oplus S_{1}(i) \oplus S_{1}(i) \oplus S_{2}(i) \oplus S_{3}(i)$$
e quindi
$$S'_{4}(i) = S_{4}(i) \oplus S'_{1}(i) \oplus S_{1}(i)$$

## Referenze