# The heir of Lyskar

Al momento per il motore di gioco sono identificabili dei macrogruppi come listato di seguito.
- Gestore degli input utente
- Giocatore (Osorin: movimento, azioni base, ecc.)
- Sistema di casting (da tastiera, mouse, gamepad)
- User Interface (UI) che comprende la finestra di dialogo gestita da utente
- Coordinatore degli attori (quando Osorin lancia una magia, il coordinatore informa gli oggetti colpiti)
- Classi NPC (nemici, animali, pericoli ambientali, enigmi, personaggi statici, ecc.)
- Gestore mappa (livelli che contengono oggetti interagibili, nemici, personaggi, ecc.)

<img src="LyskarEngineDiagram.png" alt="Diagramma dell'architettura"/>

### Input utente
Il gestore dell'input utente muove Osorin sullo schermo, controlla la finestra dei dialoghi e gestisce i comandi per l'inserimento di rune.

### Gestore mappa
Il gestore mappa si occupa di caricare, cambiare e deallocare livelli. 
Carica tutti gli oggetti necessari, compresi i personaggi. Carica Osorin e lo posiziona nel suo punto di partenza, così
come gli NPC. Si occupa anche di salvare le modifiche alla mappa, come ad esempio una determinata porta è stata sbloccata, oppure se un gruppo di nemici o boss è stato sconfitto, ecc.

### Attori - Osorin e NPC
Un attore è un qualsiasi oggetto del gioco, contiene vari componenti che lo rendono unico. Principalmente un attore
avrà una componente grafica, una componente di l'AI etc.
Osorin e NPC sono a loro volta degli attori. Altri esempi: strega con pentolone, Troll, Bracere, Porta, ecc.

Ogni attore eredita da una classe base che contiene tutti i metodi e proprietà per interagire con il coordinatore, che li interfaccia gli uni con gli altri.

### Coordinatore Attori
Il coordinatore degli attori si occupa di coordinare i vari oggetti e di farli comunicare insieme.
Un attore si registra al coordinatore e può mandargli messaggi destinati ad altri attori, il coordinatore
si occuperà di gestire e recapitare tali messaggi (ad esempio se Osorin lancia una magia X, dice al coordinatore
che sta lanciando la magia ed esso si occuperà di recapitare il messaggio agli attori coinvolti).

Bisogna tenere in considerazione anche i Signals di Godot per implementare questo sistema, potrebbero essere
un sostituto del coordinatore (Osorin emette il segnale di lancio di magia e gli attori connessi a tale segnale
ricevono l'evento).

### Spell Casting
Sistema per il lancio di spell, riceve le rune immesse e controlla che è un incantesimo esistente e 
lo conferma al coordinatore di attori il quale informerà gli attori coinvolti (se il coordinatore è sostituito
con i soli Signals, questo sistema conferma lo spell a chi lo ha lanciato così lui emette i segnali).

### UI
Menu principale, HUD e menu in game.

## Approccio Top Down dell'Architettura

Partendo da una visione dall'alto dell'architettura del gioco, possiamo identificare (from top to down):
- sistema che gestisce livelli
- livelli: composti dal campo di gioco e dagli attori (personaggi, oggetti etc)
- attore: il game object base a cui si aggiungono componenti
- componente: grafica, AI, varie proprietà come i punti vita etc