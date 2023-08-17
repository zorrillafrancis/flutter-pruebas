// To parse this JSON data, do
//
//     final facturasListadoModel = facturasListadoModelFromJson(jsonString);

import 'dart:convert';

FacturasListadoModel facturasListadoModelFromJson(String str) => FacturasListadoModel.fromJson(json.decode(str));

String facturasListadoModelToJson(FacturasListadoModel data) => json.encode(data.toJson());

class FacturasListadoModel {
    List<Value> value;
    bool succeeded;
    dynamic message;
    dynamic error;

    FacturasListadoModel({
        required this.value,
        required this.succeeded,
        required this.message,
        required this.error,
    });

    factory FacturasListadoModel.fromJson(Map<String, dynamic> json) => FacturasListadoModel(
        value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
        succeeded: json["succeeded"],
        message: json["message"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
        "succeeded": succeeded,
        "message": message,
        "error": error,
    };
}

class Value {
    int id;
    String numeroFactura;
    DateTime fecha;
    String? nombre;
    int pkidcliente;
    String? tiempoentrega;
    double itebis;
    double? total;
    String? emailcliente;
    int? cotizacion;
    int pkidempresa;
    int? pkidsuplidorInformar;
    int? itbisPorc;
    int? pkidestatus;
    int? recibo;
    int? pkidcompaniaEnvio;
    String? usuario;

    Value({
        required this.id,
        required this.numeroFactura,
        required this.fecha,
        required this.nombre,
        required this.pkidcliente,
        required this.tiempoentrega,
        required this.itebis,
        required this.total,
        required this.emailcliente,
        required this.cotizacion,
        required this.pkidempresa,
        required this.pkidsuplidorInformar,
        required this.itbisPorc,
        required this.pkidestatus,
        required this.recibo,
        required this.pkidcompaniaEnvio,
        required this.usuario,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        numeroFactura: json["numeroFactura"],
        fecha: DateTime.parse(json["fecha"]),
        nombre: json["nombre"],
        pkidcliente: json["pkidcliente"],
        tiempoentrega: json["tiempoentrega"],
        itebis: json["itebis"],
        total: json["total"],
        emailcliente: json["emailcliente"],
        cotizacion: json["cotizacion"],
        pkidempresa: json["pkidempresa"],
        pkidsuplidorInformar: json["pkidsuplidorInformar"],
        itbisPorc: json["itbisPorc"],
        pkidestatus: json["pkidestatus"],
        recibo: json["recibo"],
        pkidcompaniaEnvio: json["pkidcompaniaEnvio"],
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "numeroFactura": numeroFactura,
        "fecha": fecha.toIso8601String(),
        "nombre": nombre,
        "pkidcliente": pkidcliente,
        "tiempoentrega": tiempoentrega,
        "itebis": itebis,
        "total": total,
        "emailcliente": emailcliente,
        "cotizacion": cotizacion,
        "pkidempresa": pkidempresa,
        "pkidsuplidorInformar": pkidsuplidorInformar,
        "itbisPorc": itbisPorc,
        "pkidestatus": pkidestatus,
        "recibo": recibo,
        "pkidcompaniaEnvio": pkidcompaniaEnvio,
        "usuario": usuario,
    };
}
