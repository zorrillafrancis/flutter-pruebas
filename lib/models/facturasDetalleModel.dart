// To parse this JSON data, do
//
//     final facturaDetalle = facturaDetalleFromJson(jsonString);

import 'dart:convert';

FacturaDetalle facturaDetalleFromJson(String str) =>
    FacturaDetalle.fromJson(json.decode(str));

String facturaDetalleToJson(FacturaDetalle data) => json.encode(data.toJson());

class FacturaDetalle {
  final Value value;
  final bool succeeded;
  final dynamic message;
  final dynamic error;

  FacturaDetalle({
    required this.value,
    required this.succeeded,
    required this.message,
    required this.error,
  });

  factory FacturaDetalle.fromJson(Map<String, dynamic> json) => FacturaDetalle(
        value: Value.fromJson(json["value"]),
        succeeded: json["succeeded"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "value": value.toJson(),
        "succeeded": succeeded,
        "message": message,
        "error": error,
      };
}

class Value {
  final Header header;
  final List<Detalle> detalle;

  Value({
    required this.header,
    required this.detalle,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        header: Header.fromJson(json["header"]),
        detalle:
            List<Detalle>.from(json["detalle"].map((x) => Detalle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "detalle": List<dynamic>.from(detalle.map((x) => x.toJson())),
      };
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "itebis": itebis,
        "cantidad": cantidad,
        "subtotal": subtotal,
        "preciounitario": preciounitario,
        "descuento": descuento,
      };
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "numeroFactura": numeroFactura,
        "fecha": fecha.toIso8601String(),
        "total": total,
        "itbisPorc": itbisPorc,
        "cliente": cliente.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "cliente": cliente,
        "ciudad": ciudad,
        "nombre": nombre,
        "telefono": telefono,
        "email": email,
      };
}
