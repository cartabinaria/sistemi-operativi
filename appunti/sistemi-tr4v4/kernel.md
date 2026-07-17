---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 17:45:15
links:
  - "[[lecture-27022025151550|Lecture 27022025151550]]"
  - "[[lecture-28022025091715|Lecture 28022025091715]]"
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
---
# Kernel
---
## Tipologie
Esistono diverse tipologie di kernel:
- [[kernel-monolitico|monolitici]]
- [[microkernel|microkernel]]
- [[kernel-ibrido|ibridi]]
- [[exokernel|ExoKernel]] - si partizionano le risorse del sistema per scopi diversi; non fornisce system call, fornisce solo supporto ad altri sistemi operativi
- [[anykernel|AnyKernel]] - i driver possono essere caricati in user space --> estremamente comodo per sviluppare device driver; il concetto può essere esteso a file system e stack di rete

## Schema
![[kernel-schema.png]]

## Referenze