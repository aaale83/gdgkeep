// Questa classe rappresenta un custom widget della lista delle nostre note
// Importiamo alucne librerie tra cui il pacchetto flutter_staggered_grid_view
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gdg_keep/models/gdg_note.dart';

// Definiamo una classe chiamata NotesGridView che estende StatelessWidget.
class NotesGridView extends StatelessWidget {

  // Definiamo alcune variabili final ovvero la lista delle note reperite dal finto backend ed il numero di colonne in cui voglia organizzare le nostre note
  // Per final si intende una variabile cone può essere assegnata solo una volta e non può essere modifica dopo la sua inizializzazione
  final List<GDGNote> list;
  final int columns;

  // Tramite il costruttore obblighiamo tramite la parola required l'assegnazione di questi valori durante l'inizializzazione della classe
  const NotesGridView({
    super.key,
    required this.list,
    required this.columns,
  });

  // build è un metodo che costruisce il Widget. Accetta come parametro il context (o contesto in italiano)
  // Il contesto rappresenta la posizione di un widget all'interno della gerarchia di widget. Viene utilizzato per accedere a vari aspetti dell'applicazione, come il tema, la navigazione,
  // informazioni sul layout e per trovare widget padre o figlio all'interno della gerarchia.
  @override
  Widget build(BuildContext context) {
    // Iniziamo a construire il widget
    // Partiamo definendo la larghezza dell'area contenente le note sottraendo 300 (la larghezza del menù a sinistra) alla larghezza attuale dell'app.
    // Per ottenere la larghezza della finestra dell'app viene usata la classe MediaQuery tramite il metodo sizeOf, il context e la proprietà width
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 300,
      // Andiamo a visualizzare le note come un mosaico tramite il widget MansonryGridView del pacchetto flutter_staggered_grid_view importato
      // .count è comunemente utilizzato come convenzione nei nomi di alcuni costruttori per indicare che il widget creato avrà un numero specifico di elementi in un layout
      child: MasonryGridView.count(
        // Definiamo un animazione di scrolling
        physics: const BouncingScrollPhysics(),
        // Definiamo il numeri di elementi da iterare, nel nostro caso il numero di elementi contenuti nella lista list viene recuperata tramite la proprietà length
        itemCount: list.length,
        // Definiamo il numero di colonne tramite il parametro assegnato al momento della costruzione del widget
        crossAxisCount: columns,
        // Iniziamo la costruzione della lista
        itemBuilder: (context, index) {
          // Per ogni elemento creiamo un Container
          return Container(
            // Avrà questo margine ovvero 0 sinistra, 24 sopra, 24 destra, 0 sotto
            margin: const EdgeInsets.fromLTRB(0, 24, 24, 0),
            // Avrà un padding su tutti i lati di 16
            padding: const EdgeInsets.all(16),
            // Avrà queste proprietà decorative definitire tramite la classe BoxDecoration:
            decoration: BoxDecoration(
                // Il colore di sfondo
                // Per ottenere il colore concateniazo la parola 0xFF con il colore proveniente dal modello della singola GDGNote prelevata dal backend fittizio
                // Color vuole come parametro un numero intero quindi convertiamo il valore esadecimale in un intero tramite il metodo parse della classe int
                color: Color(int.parse("0xFF${list[index].colore!}")),
                // Tutti gli angoli arrotondati di valore 12
                borderRadius: BorderRadius.circular(12)
            ),
            // All'interno del riquadro definiamo una colonna
            child: Column(
                // Tutti gli elementi saranno all'ineati a sinistra
                crossAxisAlignment: CrossAxisAlignment.start,
                // Definiamo gli elementi della colonna ovvero
                children: [
                  // Un testo con il titolo contenuto nel modello GDGNote della singola nota
                  Text(
                    list[index].titolo!,
                    // Stilizzato tramite TextStyle con
                    style: const TextStyle(
                      // Font in grassetto
                      fontWeight: FontWeight.bold,
                      // Font grande 16
                      fontSize: 16,
                    ),
                  ),
                  // Usiamo un SizedBox per spaziare in altezza di 16
                  const SizedBox(
                    height: 16,
                  ),
                  // Un testo con il testo contenuto nel modello GDGNote della singola nota
                  Text(list[index].testo!),
                ]
            ),
          );
        },
      ),
    );
  }
}
