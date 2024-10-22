// Questa classe rappresenta un custom widget del menù a sinistra
// Importiamo la libreria material
import 'package:flutter/material.dart';

// Definiamo una classe chiamata LeftMenu che estende StatelessWidget.
class LeftMenu extends StatelessWidget {

  // Passiamo un parametro opzionale key alla classe, (opzionale in quanto è delimitato dalle parentesi graffe).
  // La chiave permette di identificare in maniera univoca il widget all'interno dell'albero dei widget.
  const LeftMenu({super.key});

  // build è un metodo che costruisce il Widget. Accetta come parametro il context (o contesto in italiano)
  // Il contesto rappresenta la posizione di un widget all'interno della gerarchia di widget. Viene utilizzato per accedere a vari aspetti dell'applicazione, come il tema, la navigazione,
  // informazioni sul layout e per trovare widget padre o figlio all'interno della gerarchia.
  @override
  Widget build(BuildContext context) {
    // Iniziamo a construire il widget
    // Partiamo definendo la larghezza di 300 tramite un SizedBox
    return SizedBox(
      width: 300,
      // Come figlio passiamo una Colonna
      child: Column(
        // Allineiamo gli elementi della colonna partendo da sinistra
        crossAxisAlignment: CrossAxisAlignment.start,
        // Definiamo la lista dei widget all'interno della colonna
        children: [
          // Creiamo uno spazio in altezza di 16 sempre tramite un SizedBox
          const SizedBox(
            height: 16,
          ),
          // Definiamo una riga con del padding 32 a sinistra, sopra 16, destra 16, sotto 16
          // TODO: Chiedere ai presenti come si potrebbe migliorare il DRY in questa porzione di codice
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 16, 16),
            child: Row(
              // Definiamo gli elementi della riga
              children: [
                // Primo elemento un'immagine negli asset con l'icona di una lampada di larghezza 32
                Image.asset("assets/img/idea.png", width: 32),
                // Uno spazio in larghezza di 16 sempre tramite uno SizedBox
                const SizedBox(
                  width: 16,
                ),
                // Un testo chiamato Note
                const Text("Note"),
              ],
            ),
          ),
          // Definiamo una riga con del padding 32 a sinistra, sopra 16, destra 16, sotto 16
          // TODO: Chiedere ai presenti come si potrebbe migliorare il DRY in questa porzione di codice
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 16, 16),
            child: Row(
              // Definiamo gli elementi della riga
              children: [
                // Primo elemento un'immagine negli asset con l'icona di un ingranaggio di larghezza 32
                Image.asset("assets/img/settings.png", width: 32),
                // Uno spazio in larghezza di 16 sempre tramite uno SizedBox
                const SizedBox(
                  width: 16,
                ),
                // Un testo chiamato Impostazioni
                const Text("Impostazioni"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
