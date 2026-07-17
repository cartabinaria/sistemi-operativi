---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 05-11-2023 22:47:30
links:
  - "[[lecture-02112023130607|Lecture 02112023130607]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Trap
---
## Definizione
> Una **trap** è una [[invocazione-di-procedura|chiamata di procedura]] _automatica_ effettuata quando si verificano 2 eventi particolari:
> - _[[istruzioni-isa-composizione|opcode]] non definito_
> - _accesso ad area di memoria non consentito_
> 
> Al verificarsi di uno di questi eventi il controllo viene trasferito a una specifica procedura chiamata **gestore di trap**.
> Formalmente, le trap sono classificate come **[[interrupt|interrupt]] software**, generati dal processore stesso in situazioni di errore (o di [[system-call|system call]]).

Il _gestore di trap_ potrebbe, per esempio, comunicare l'errore al processo che l'ha scatenato e non restituirgli più il controllo.

Il [[page-fault|page fault]] e' una trap importante nell'ambito della [[memoria-virtuale|memoria virtuale]], in quanto consente di segnalare se un indirizzo virtuale non sia attualmente in [[ram|RAM]], cosi' da far partire il meccanismo di trasferimento delle pagine (attraverso un [[algoritmi-di-paginazione|algoritmo di paginazione]]).

## Referenze