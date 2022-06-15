import 'package:meta/meta.dart';
import 'dart:convert';

ListaAutos3 listaAutos3FromJson(String str) =>
    ListaAutos3.fromJson(json.decode(str));

String listaAutos3ToJson(ListaAutos3 data) => json.encode(data.toJson());

class ListaAutos3 {
  ListaAutos3({
    required this.patente,
    required this.marca,
    required this.precio,
  });

  String patente;
  String marca;
  String precio;

  factory ListaAutos3.fromJson(Map<String, dynamic> json) => ListaAutos3(
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
