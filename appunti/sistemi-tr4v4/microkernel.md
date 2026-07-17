---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 17:48:28
links:
  - "[[lecture-27022025151550|Lecture 27022025151550]]"
---
# Microkernel
---
## Introduzione
L'idea e' di rimuovere dal [[kernel|kernel]] tutte le parti non essenziali, e di implementare queste come processi utente.

Per esempio, per l'accesso a un file un processo interagisce con il gestore del file system (esterno al kernel) che a sua volta interagira' con il kernel vero e proprio per accedere fisicamente alla memoria.

Per la sua implementazione _serve un meccanismo di comunicazione_, per permettere ai _processi client_ di chiedere servizi ai _processi server_: **si usa il [[message-passing|message passing]]**!
![[microkernel-message-passing.png]]

Di fatto le uniche [[system-call|system call]] implementate dal kernel sono `send` e `receive`.
Un esempio di utilizzo sarebbe quindi il seguente:
```c
int open(char* file, ...) {
	msg = < OPEN, file, ... >;
	send(msg, file-server);
	fd = receive(file-server);
	return fd;
}
```

I vantaggi di un microkernel sono chiaramente la modularita', personalizzabilita' ed espandibilita': tutto questo, pero', a discapito dell'efficienza. Quindi sono meglio i microkernel o i [[kernel-monolitico|kernel monolitici]]?[^1]

Se va in crash un modulo, il sistema operativo continua a funzionare!

## Osservazione
E' il tipo di kernel che **separa la politica dal meccanismo**: il _kernel implementa solo il meccanismo_, lasciando ai _gestori_ (esterni al kernel) _le decisioni politiche_.

E' questo il suo punto di forza, perche' garantisce grande modularita'.

## Referenze

[^1]: [dibattito tra Torvalds e Tanenbaum](https://en.wikipedia.org/wiki/Tanenbaum%E2%80%93Torvalds_debate)
