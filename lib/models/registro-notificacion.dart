import 'dart:convert';

RegistroNotificacion registroNotificacionFromJson(String str) =>
    RegistroNotificacion.fromJson(json.decode(str));

String registroNotificacionToJson(RegistroNotificacion data) =>
    json.encode(data.toJson());

class RegistroNotificacion {
  final int id;
  final DateTime fecha;
  final String token;
  final int pkidusuario;

  RegistroNotificacion({
    required this.id,
    required this.fecha,
    required this.token,
    required this.pkidusuario,
  });

  factory RegistroNotificacion.fromJson(Map<String, dynamic> json) =>
      RegistroNotificacion(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        token: json["token"],
        pkidusuario: json["pkidusuario"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha.toIso8601String(),
        "token": token,
        "pkidusuario": pkidusuario,
      };
}
