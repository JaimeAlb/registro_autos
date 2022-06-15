import 'dart:convert';

LocalAuto localAutoFromJson(String str) =>
    LocalAuto.fromJson(json.decode(str));

String localAutoToJson(LocalAuto data) => json.encode(data.toJson());

class LocalAuto {
  LocalAuto({
    required this.patente,
    required this.marca,
    required this.precio,
  });

  String patente;
  String marca;
  String precio;

  factory LocalAuto.fromJson(Map<String, dynamic> json) => LocalAuto(
        patente: json["Patente"],
        marca: json["Marca"],
        precio: json["Precio"],
      );

  Map<String, dynamic> toJson() => {
        "Patente": patente,
        "Marca": marca,
        "Precio": precio,
      };
}
