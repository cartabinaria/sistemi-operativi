---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 18-06-2025 18:10:35
links:
  - "[[lecture-23042025152007|Lecture 23042025152007]]"
---
# Partizione di un disco
---
## Introduzione
> Una **partizione** e' una porzione indipendente di un disco che puo' ospitare un [[file-system|file system]].

## Struttura
Una partizione si divide in:
- **boot block** --> l'[[mbr|MBR]] (o [[gpt|GPT]]) lo carica per eseguire la partizione;
- **superblock** --> contiene informazioni globali sul tipo di file system della partizione;
- **tabella della gestione dello spazio libero**
- **tabella della gestione dello spazio occupato** --> non presente in tutti i file system (per esempio in quelli non [[fat|FAT]] o non [[unix|Unix]][^1]);
- **root dir**
- **[[file|file]] e directory**

## Referenze

[^1]: gli i-node sono salvati li'!
