// To parse this JSON data, do
//
//     final listaProductos = listaProductosFromJson(jsonString);

import 'dart:convert';

List<ListaAutos2> listaAutosFromJson2(String str) =>
    List<ListaAutos2>.from(
        json.decode(str).map((x) => ListaAutos2.fromJson(x)));

String listaMarcasToJson2(List<ListaAutos2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaAutos2 {
  ListaAutos2({
    // required this.id,
    required this.patente,
    required this.marca,
    required this.precio,
  });

  // int id;
  String patente;
  String marca;
  int precio;

  factory ListaAutos2.fromJson(Map<String, dynamic> json) => ListaAutos2(
        // id: json["Id"],
        patente: json["Patente"],
        marca: json["Marca"],
        precio: json["Precio"],
      );

  Map<String, dynamic> toJson() => {
        // "Id": id,
        "Patente": patente,
        "Marca": marca,
        "Precio": precio,
      };
}
