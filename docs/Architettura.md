# The heir of Lyskar

Al momento per il motore di gioco sono identificabili dei macrogruppi come listato di seguito.
- Gestore degli input utente
- Giocatore (Osorin: movimento, azioni base, ecc.)
- Sistema di casting (da tastiera, mouse, gamepad)
- User Interface (UI) che comprende la finestra di dialogo gestita da utente
- Coordinatore degli attori (quando osorin lancia una magia, il coordinatore informa gli oggetti colpiti)
- Classi NPC (nemici, animali, pericoli ambientali, enigmi, personaggi statici, ecc.)
- Gestore delle mappe (livelli che contengono oggetti interagibili, nemici, personaggi, ecc.)

<img src="LyskarEngineDiagram.png" alt="Diagramma dell'architettura"/>

### Input utente
Il gestore dell'input utente muove Osorin sullo schermo, controlla la finestra dei dialoghi 
per quanto riguarda i comandi Prossima linea di dialogo, Accelera rendering e Salta dialogo, nonché redirige i comandi ricevuti per gestire l'inserimento di rune.

### Gestore mappa
Il gestore di mappa crea tutti gli oggetti necessari per la fruibilità di ogni data sezione di gioco: carica e visualizza lo sfondo, insieme a tutti gli altri asset grafici e interagibili che sono presenti nella propria sezione, crea Osorin e lo posiziona nel suo punto di partenza, infine crea 
gli NPC e li posiziona nei punti a loro assegnati. Il generatore di mappa si occupa anche di ricordarsi lo stato di ogni sezione di mappa: ad esempio se una determinata porta è stata sbloccata, se un gruppo di nemici o boss è stato abbattuto, ecc.

### Attori - Osorin e NPC

### Coordinatore Attori
Il coordinatore degli attori è un motore generico a cui ogni oggetto generato si "registra" nel momento in cui viene creato. 
Ogni oggetto fornisce alla macchina a stati una lista di stati, di stimoli desiderati e di
segnali disponibili. La macchina a stati si occupa di coordinare i vari oggetti e di farli comunicare
insieme. La macchina a stati internamente gestisce una turnazione il cui stimolo di commutazione
proviene dal sistema di temporizzazione di Godot; quindi un Timer oppure delle chiamate provenienti
da _process().
Ciascun oggetto ha diversi stati per gestire il proprio funzionamento. Ad esempio l’ogetto Osorin avrà,
come la demo del kraken, uno stato in cui alza le braccia, uno stato in cui muove le mani per lanciare
un incantesimo, uno stato per abbassare le braccia, ecc.
La macchina a stati principale cui l’oggetto si è registrato riceve i messaggi inviati dall’oggetto A, ne valuta la correttezza (cioè se il destinatario esiste e se il messaggio ha senso per quel destinatario) e poi li invia all’oggetto B. Ad esempio, Osorin è l’oggetto A ed indirizza l’incantesimo LFDG all’oggetto
Sasso. Un incantesimo Lévita ha senso per un sasso, ma un incantesimo Fuoco no. Inoltre la macchina
a stati gestisce la temporizzazione degli stati di ciascun oggetto.
Ad ogni stimolo temporale la macchina a stati commuta tra i vari oggetti, uno per uno, legge i messaggi
da esso accodati e gli invia la coda messaggi ad esso destinata. La macchina a stati fa quindi da
“collante” tra i vari oggetti e permette che questi possano interagire tra loro pur mantenendo il codice a
compartimenti stagni. La dinamicità consiste nel fatto che le diverse combinazioni di messaggi da e per
i vari oggetti e gli stati che ciascun oggetto può assumere sono variabili a seconda di quali oggetti si
siano collegati ad essa. Come tali, questi stati possono essere gestiti con del codice molto semplice. Ad
esempio, se Osorin sta muovendo le braccia allora non potrà completare l’incantesimo finché le braccia
non si saranno alzate. Allo stesso modo un troll arciere dovrà prendere una nuova freccia dalla faretra e
incoccarla prima di poterla lanciare.

Esempi di stati:
Spostamento, incocca freccia, mira, lancia freccia, scappa, ecc.
Esempi di messaggi inviati:
Selezione bersaglio, lancio magia, attivazione di un controllo (ad esempio l’apertura delle porte in
Doom)
Esempi di messaggi accettati:
Selezione accettata, Danni da incantesimo accettati, Blocco da magica “congela” accettato, ecc.
Esempi di stimoli accettati, provenienti dalla macchina a stati:
Tick temporale (ogni tot decimi di frame), Timer (scadenza di un timer richiesto e configurato dallo
stesso oggetto che lo riceve), Osorin è entrato nel raggio d’azione, Osorin è uscito dal raggio d’azione,
ecc.

### Spell Casting