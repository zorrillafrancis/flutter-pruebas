// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  final dynamic value;
  final bool succeeded;
  final dynamic message;
  final dynamic error;

  Response({
    required this.value,
    required this.succeeded,
    required this.message,
    required this.error,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        value: json["value"],
        succeeded: json["succeeded"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "succeeded": succeeded,
        "message": message,
        "error": error,
      };
}
