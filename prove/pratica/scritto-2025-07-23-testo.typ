#align(center, text(14pt, weight: "bold")[
  Prova Pratica di Laboratorio di Sistemi Operativi \
  23 luglio 2025
])

#set par(
  //leading: em,
  spacing: 2.00em,
  justify: true,
)

*Esercizio 0 (_"Se copiate, vi cacciamo"_)* \
Rendete la vostra directory home inaccessibile ad altri utenti (sia in lettura
che in esecuzione). Si puo' tenere una sola directory in `/public` che abbia
come nome il vostro username e.g. \
`"/public/giovanni.rossi"` e che abbia permessi `700`.

*Non usare system o popen o simili! Non fare exec di "sh -c". (per python usare
subprocess e non os.system, os.spawn).*

*Esercizio 1: Linguaggio C (obbligatorio) 20 punti* Scrivere un programma
_sha1dir_ con due argomenti: primo è il pathname di una directory, il secondo
un pathname inesistente dove poter creare una directory. \
Il programma deve ricostruire nella directory creata una struttura ad albero
identica a quella che ha come radice il primo parametro. I nodi che nell'albero
della prima directory sono file regolari corrispondono nel secondo albero a file
che contengono la hash sha1 del file della primo albero.

*Esercizio 2: Linguaggio C: 10 punti* Scrivere un programma _sha1diff_ che
usando gli stessi parametri passati precedentemente al programma _sha1dir_
dell'esercizio 1 e mette in output l'elenco dei file che sono stati modificati
(la hash sha1 non corrisponde).

*Esercizio 3: Python o bash: 10 punti:* Scrivere un programma C o uno script
bash _dremcont_. _dremcont_ ha due parametri: un file f e una directory d. Tutti
i file nella directory d e nelle sue sottodirectory che hanno contenuto uguale
a f devono essere cancellati

*Esercizio 4: ("Consegnate! E' ora!")*:
Usando il vostro account di posta elettronica di unibo, consegnare lo script e
il sorgente dei programmi C, in attachment separati, entro il tempo a
disposizione, via e-mail a: #underline[renzo chiocciola cs.unibo.it]. l'oggetto
della mail deve essere uguale a *PROVAPRATICA*, i nomi dei file in allegato
*devono contenere il vostro cognome* (per evitare confusioni in fase di correzione).
Rinominate i file python .py con suffisso diverso. \
INOLTRE: \
Se volete che il vostro lavoro venga giudicato, lasciate aperta la vostra sessione
(incluso il vostro editor) *e una finestra terminale che mostri l'output del
comando sha1sum di tutti i file consegnati* e lasciate il laboratorio. Verrete
richiamati uno alla volta per una breve discussione sul vostro elaborato. \
*NB: i programmi e gli script consegnati devono essere completamente privi di commenti*.
Non verranno accettate e-mail contenenti puntatori a file memorizzati in cloud.
