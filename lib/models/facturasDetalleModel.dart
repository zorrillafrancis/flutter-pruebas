class FacturaDetalle {
  final Header header;
  final List<Detalle> detalle;

  FacturaDetalle({required this.header, required this.detalle});
}

class Header {
  final int id;
  final String numeroFactura;
  final DateTime fecha;
  final double? total;
  final int? itbisPorc;
  final Cliente cliente;

  Header({
    required this.id,
    required this.numeroFactura,
    required this.fecha,
    required this.total,
    required this.itbisPorc,
    required this.cliente,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        id: json["id"],
        numeroFactura: json["numeroFactura"],
        fecha: DateTime.parse(json["fecha"]),
        total: json["total"],
        itbisPorc: json["itbisPorc"],
        cliente: Cliente.fromJson(json["cliente"]),
      );
}

class Detalle {
  final int id;
  final String codigo;
  final String descripcion;
  final double? itebis;
  final int cantidad;
  final double? subtotal;
  final double? preciounitario;
  final double? descuento;

  Detalle({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.itebis,
    required this.cantidad,
    required this.subtotal,
    required this.preciounitario,
    required this.descuento,
  });

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        itebis: json["itebis"]?.toDouble(),
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        preciounitario: json["preciounitario"],
        descuento: json["descuento"],
      );
}

class Cliente {
  final String cliente;
  final String ciudad;
  final String nombre;
  final String telefono;
  final String email;

  Cliente({
    required this.cliente,
    required this.ciudad,
    required this.nombre,
    required this.telefono,
    required this.email,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        cliente: json["cliente"],
        ciudad: json["ciudad"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        email: json["email"],
      );
}
