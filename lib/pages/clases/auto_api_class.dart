import 'dart:convert';

List<AutoApiClass> listaAutosFromJson(String str) =>
    List<AutoApiClass>.from(
        json.decode(str).map((x) => AutoApiClass.fromJson(x)));

String listaMarcasToJson(List<AutoApiClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutoApiClass {
  AutoApiClass({
    required this.id,
    required this.patente,
    required this.marca,
    required this.precio,
  });

  int id;
  String patente;
  String marca;
  int precio;

  factory AutoApiClass.fromJson(Map<String, dynamic> json) => AutoApiClass(
        id: json["Id"],
        patente: json["Patente"],
        marca: json["Marca"],
        precio: json["Precio"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Patente": patente,
        "Marca": marca,
        "Precio": precio,
      };
}
