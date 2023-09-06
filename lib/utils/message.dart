enum FromWho { mine, hers }

class Message {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  Message({required this.text, this.imageUrl, required this.fromWho});
}

class Items {
  final String nombre;
  final String? apellido;

  Items(this.nombre, this.apellido);
}

class Totals {
  final int total;
  final int subtotal;
  final int itbis;

  Totals({required this.total, required this.subtotal, required this.itbis});
}
