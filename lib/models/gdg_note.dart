// Modello di dati che rappresenta la nostra nota
// Definiamo il nome della classe
class GDGNote {
  // Definiamo degli attributi tramite delle variabili di tipo String?. Il punto di domanda sta ad indicare che la variabile può essere anche null
  String? titolo;
  String? testo;
  String? colore;

  // Costruttore che permette di creare un'istanza della classe GDGNote
  GDGNote({this.titolo, this.testo, this.colore});

  // Costruttore che permette di creare un'istanza della classe GDGNote partedo da una mappa chiave-valore provienete da dati json decodificati
  GDGNote.fromJson(Map<String, dynamic> json) {
    titolo = json['titolo'];
    testo = json['testo'];
    colore = json['colore'];
  }

  // Metodo che converte un'istanza della classe GDGNote in una mappa chiave-valore
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titolo'] = titolo;
    data['testo'] = testo;
    data['colore'] = colore;
    return data;
  }
}