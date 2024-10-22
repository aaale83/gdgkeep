// Importiamo una serie di librerie. Una libreria è un insieme di funzioni, classi e variabili che possono essere utilizzate per estendere le funzionalità di un programma.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_keep/models/gdg_note.dart';
import 'package:gdg_keep/widgets/left_menu.dart';
import 'package:gdg_keep/widgets/notes_grid_view.dart';
import 'package:gdg_keep/widgets/top_bar.dart';

// Qualsiasi app flutter parte con la funzione main()
void main() {
  // Il metodo runApp renderizza il Widget dato
  runApp(
    // Il Widget MaterialApp crea un'app di tipo Material. Il Material Design è una specifica creata da Google per il design di UI (https://m3.material.io/get-started)
    const MaterialApp(
      // Nasconde il banner debug nell'angolo in alto a destra dell'app
      debugShowCheckedModeBanner: false,
      // Utiliziamo il Widget GDGKeep() come home dell'app
      home: GDGKeep(),
    )
  );
}

// Dichiariamo il Widget GDGKeep tramite la relativa classe. Lo creiamo di tipo stateful in quanto dovremo cambiarne lo stato in futuro.
// La scorciatoia per creare uno stateful widget in Android Studio consiste nel digitare stful e successivamente invio.

// Definiamo una classe chiamata GDGKeep che estende StatefulWidget.
class GDGKeep extends StatefulWidget {

  // Definiamo un costruttore costante che accetta un parametro opzionale 'key'.
  // 'super.key' passa il parametro al costruttore della classe madre (StatefulWidget).
  // Il costruttore 'const' indica che questa classe può essere immutabile,
  // migliorando l'efficienza quando il widget viene ricostruito.
  const GDGKeep({super.key});

  // Sovrascrive il metodo createState che è obbligatorio per ogni StatefulWidget.
  // Questo metodo crea un'istanza dello stato associato a questo widget.
  // Qui, ritorna un oggetto di tipo _GDGKeepState, che gestirà lo stato di GDGKeep.
  @override
  State<GDGKeep> createState() => _GDGKeepState();
}

// Questa riga dichiara una classe di stato (_GDGKeepState) che è responsabile della gestione dello stato interno e del ciclo di vita del widget GDGKeep.
class _GDGKeepState extends State<GDGKeep> {

  // Creiamo una Lista di tipo GDGNote che conterrà tutte le note dentro al file json nella directory assets/json/
  // GDGNote è un modello astratto di dati che contiene una singola istanza di una nostra nota (vedere il file gdg_note.dart nella directory lib/models/ per dettagli sulla classe)
  List<GDGNote> list = [];

  // Variabile di tipo booleano per capire se il sistema è in fase di caricamento del json o ha ultimato la procedura in modo da poter renderizzare la UI
  bool _isLoading = true;
  // Variabile di tipo intero che definisce il numero di colonne standard da visualizzare nella nostra lista di note
  int columns = 4;
  // Variabile di tipo double che contiene la larghezza del nostro schermo. Successivamente verrà popolata col valore corretto. Intanto la inizializziamo a 0.
  double screenWidth = 0;

  // initState è un metodo che viene lanciato quando lo stato del Widget viene creato o più semplicemente prima che il Widget venga costruito
  @override
  void initState() {
    // Le implementazioni di questo metodo dovrebbero iniziare con una chiamata al metodo ereditato, come in super.initState()
    super.initState();
    // metodo per caricare il json all'interno della Lista precedentemente dichiarata (vedi sotto per il codice del metodo)
    _loadJson();
  }

  // build è un metodo che costruisce il Widget. Accetta come parametro il context (o contesto in italiano)
  // Il contesto rappresenta la posizione di un widget all'interno della gerarchia di widget. Viene utilizzato per accedere a vari aspetti dell'applicazione, come il tema, la navigazione,
  // informazioni sul layout, e per trovare widget padre o figlio all'interno della gerarchia.
  @override
  Widget build(BuildContext context) {

    // Utilizziamo la variabile screenWidth precedentemente creata per salvare le dimensioni in larghezza dello schermo
    // Tramite la classe MediaQuery (pensate vagamente a quelle dei CSS) ed il context riusciamo ad accedere ai valori dei getter size e width.
    // Un getter è una funzione speciale in programmazione che consente di ottenere (o "recuperare") il valore di una proprietà di un oggetto.
    screenWidth = MediaQuery.of(context).size.width;

    // Impostiamo la variabile columns a 1, 2 o 4 in base alla larghezza dello schermo. Questo ci permette di rendere responsive l'applicazione.
    // Per responsive si intende un'app che adatta la sua UI in base alle dimensioni dello schermo
    if (screenWidth < 800) {
      columns = 1;
    } else if (screenWidth < 1200) {
      columns = 2;
    } else {
      columns = 4;
    }

    // Il metodo si aspetta in ritorno (return) un Widget quindi partiamo con uno dei Widget base del Material Design ovvero lo Scaffold
    // Scaffold (dall'inglese impalcatura) è un widget che fornisce una struttura di base per la costruzione del layout di un'app.
    // Viene spesso utilizzato come contenitore principale per le schermate di un'applicazione
    return Scaffold(
      // Impostiamo il colore di sfondo (background) a bianco tramite la classe Colors ed il getter white
      backgroundColor: Colors.white,
      // body è una proprietà dello Scaffold dove andiamo a definire il corpo dell'app. Tramite un operatore ternario verifichiamo lo stato del caricamento dei dati. Se la variabile _isLoading è true visualizziamo quanto definitio dopo il ? altrimenti visualizziamo quanto definito dopo i :
      // L'operatore ternario è un costrutto condizionale in programmazione che consente di eseguire una verifica e restituire uno dei due valori a seconda del risultato della condizione, una forma compatta di "se succede qualcosa allora fai questo altrimento fai quest'altro"
      body: _isLoading
        // _isLoading è inizialmente a true quindi visualizziamo al centro un widget tramite Center
        ? const Center(
            // Center accetta come figlio (child) un Widget, nel nostro caso CircularProgressIndicator che è il tipico "cerchio che gira" nelle app Android
            child: CircularProgressIndicator(
                // Definiamo il widget di colore blu tramite la proprietà color
                color: Colors.blue
            )
          )
        // Quando _isLoading diventerà false e verrà chiamato il cambio di stato (vedi metodo _loadJson() sotto) allora possiamo procedere alla visualizzazione della UI. Iniziamo col posizionare determinati Widget in colonna tramite il Widget Column
        : Column(
          // Column accetta più di un figlio da qui children (figli)
          children: [
            // Definiamo il custom Widget creato da noi chiamato TopBar() che conterrà logo e campo di ricerca (vedi file lib/widgets/top_bar.dart)
            const TopBar(),
            // Sotto alla TopBar() definiamo una Riga con a sinistra il menù ad elenco ed a destra il contenuto delle nostre note
            // Il widget Expanded serve a controllare come uno o più widget figli occupino lo spazio disponibile in un widget genitore che ha un'area limitata.
            Expanded(
              // La riga o Row() è un Widget che allinea più elementi in orizzontale ed accetta quindi più figli come le Column
              child: Row(
                // Tramite il CrossAxisAlignment ed il getter start, impostiamo l'allineamento verticale della riga partendo dall'inizio. Questo ci permette di allineare tutti i widget figli partendo dall'alto e non al centro
                crossAxisAlignment: CrossAxisAlignment.start,
                // Lista dei figli
                children: [
                  // Custom Widget creato da noi con il menù a sinistra (vedi file lib/widgets/left_menu.dart)
                  const LeftMenu(),
                  // Custom Widget creato da noi che visualizza la lista delle note (vedi file lib/widgets/notes_grid_view.dart)
                  NotesGridView(list: list, columns: columns),
                ],
              ),
            )
          ],
        ),
      // Aggiungiamo il floating action button nell'angolo in basso a destra dell'app. Nel caso la variabile booleana _isLoading sia a true lo nascondiamo. Successivamente diventerà a false quando il caricamento è stato ultimato e verrà quindi visualizzato l'elemento.
      // Il floating action button è un elemento del design Material che esegue una delle azioni principali dell'app. (INFO: https://m2.material.io/components/buttons-floating-action-button#usage)
      // Impostiamo anche un padding attorno al FAB di 16 in basso ed a destra
      floatingActionButton: _isLoading ? Container() : Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
        // Aggiungiamo il FAB
        child: FloatingActionButton(
          onPressed: () {
            // In questa callback viene eseguito il codice alla pressione del FAB
          },
          // Impostiamo il background color a blue
          backgroundColor: Colors.blue,
          // Impostiamo l'icona + di colore bianco all'interno del FAB
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Questo è il metodo che carica il JSON e simula il recupero di dati da un backend con un ritardo fittizio di due secondi.
  // JSON sta per JavaScript Obect Notation. E' un formato standard aperto per lo scambio dei dati (https://en.wikipedia.org/wiki/JSON)
  // Future sta ad indicare un'operazione asincrona che verrà completata in un momento futuro. Per questo motivo, oltre alla parola Future ed il nome del nostro metodo, aggiungiamo async prima delle parentesi graffe
  Future _loadJson() async {
    // await implica l'aspettare del compimento dell'operazione asincrona.
    // Future è una classe che esegue un'operazione computazionale in un momento futuro e non nell'immediato, in questo caso specifichiamo un ritardo (delay) della durata (Duration) di 2 secondi.
    await Future.delayed(const Duration(seconds: 2));
    // A questo punto andiamo a caricare il file json nella cartella assets e lo salviamo in una variabile di tipo String
    // rootBundle è un oggetto che ci permette di accedere alle risorse all'interno del pacchetto dell'app
    String jsonString = await rootBundle.loadString('assets/json/notes.json');
    // Decodifichiamo il json all'interno di una variabile
    var jsonResponse = json.decode(jsonString);
    // Per ogni elemento del json
    for (var singleValue in jsonResponse) {
      // Aggiungiamo alla lista chiamata list un oggetto di tipo GDGNote contenente i valori prelevati dal singolo oggetto nel json decodificato
      list.add(GDGNote.fromJson(singleValue));
    }
    // Ricostruaimo l'interfaccia richiamando il metodo setState ed impostando la variabile _isLoading a false in quanto l'ipotetico reperimento dei dati è stato ultimato
    setState(() {
      _isLoading = false;
    });
  }

}
