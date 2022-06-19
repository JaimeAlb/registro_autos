import 'dart:convert';

List<ListaAutos> listaAutosFromJson(String str) =>
    List<ListaAutos>.from(
        json.decode(str).map((x) => ListaAutos.fromJson(x)));

String listaMarcasToJson(List<ListaAutos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaAutos {
  ListaAutos({
    required this.id,
    required this.patente,
    required this.marca,
    required this.precio,
  });

  int id;
  String patente;
  String marca;
  int precio;

  factory ListaAutos.fromJson(Map<String, dynamic> json) => ListaAutos(
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