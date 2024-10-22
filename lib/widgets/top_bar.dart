// Questa classe rappresenta un custom widget della barra in alto
// Importiamo la libreria material
import 'package:flutter/material.dart';

// Definiamo una classe chiamata TopBar che estende StatelessWidget.
class TopBar extends StatelessWidget {

  // Passiamo un parametro opzionale key alla classe, (opzionale in quanto è delimitato dalle parentesi graffe).
  // La chiave permette di identificare in maniera univoca il widget all'interno dell'albero dei widget.
  const TopBar({super.key});

  // build è un metodo che costruisce il Widget. Accetta come parametro il context (o contesto in italiano)
  // Il contesto rappresenta la posizione di un widget all'interno della gerarchia di widget. Viene utilizzato per accedere a vari aspetti dell'applicazione, come il tema, la navigazione,
  // informazioni sul layout e per trovare widget padre o figlio all'interno della gerarchia.
  @override
  Widget build(BuildContext context) {
    // Iniziamo a construire il widget
    // Partiamo definendo una colonna
    return Column(
      // Deviniamo la lista degli elementi della colonna stessa
      children: [
        // Definiamo un padding di 24 su tutti i lati
        Padding(
          padding: const EdgeInsets.all(24),
          // Successivamente definiamo una riga
          child: Row(
            // con i seguenti elementi
            children: [
              // L'immagine del logo con larghezza 48
              Image.asset("assets/img/logo.png", height: 48),
              // Uno spazio orizzontale di 16 tramite SizedBox
              const SizedBox(
                width: 16,
              ),
              // Un testo con il titolo dell'app
              const Text(
                "GDG Keep",
                // Stilizzato tramite TextStyle con:
                style: TextStyle(
                  // Font in grassetto
                  fontWeight: FontWeight.bold,
                  // Grandezza del font 18
                  fontSize: 18
                ),
              ),
              // Definiamo un ulteriore spazione di 80
              const SizedBox(
                width: 80,
              ),
              // Creiamo un riquadro largo come la larghezza della finestra meno la larghezza del menù (300) meno il padding di destra (24)
              SizedBox(
                // Definizione della larghezza
                // Per ottenere la larghezza della finestra dell'app viene usata la classe MediaQuery tramite il metodo sizeOf, il context e la proprietà width
                width: MediaQuery.sizeOf(context).width - 300 - 24,
                // Creiamo un campo di input tramite il widget TextFormFiel
                child: TextFormField(
                  // Andiamo a stilizzarlo tramite la classe InputDecoration
                  decoration: InputDecoration(
                    // Definiamo che avrà un colore di riempimento
                    filled: true,
                    // Il colore sarà grigio con una tonalità di 200
                    fillColor: Colors.grey[200],
                    // Il testo di suggerimento sarà la parola Cerca
                    hintText: 'Cerca',
                    // Lo stile del testo di suggerimento sarà definitio dalla classe TextStyle
                    hintStyle: const TextStyle(
                      // Colore del testo grigio
                      color: Colors.grey
                    ),
                    // Impostiamo il padding all'interno in maniera simmetrica, verticale 16 e orizzontale 20
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    // Definiamo il bordo del campo tramite la classe OutlineInputBorder
                    border: const OutlineInputBorder(
                      // Impostiamo gli angoli arrotondati a 12
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      // Nascondiamo il bordo
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              )
            ],
          ),
        ),
        // Creiamo una linea definendo un Container
        Container(
          // Alto uno
          height: 1,
          // Definiamo la larghezza a tutta la finestra
          width: double.infinity,
          // Colore grigio con tonalità 300
          color: Colors.grey[300],
        )
      ],
    );
  }
}
