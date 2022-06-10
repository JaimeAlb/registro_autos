import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../clases/lista_autos3.dart';

postAutoList(List<ListaAutos3> listado){

  var mapaAuto = <String, dynamic>{}; //map object
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse('https://localhost:44337/api/Autos'),
  );
  listado.map((e) async {
  mapaAuto = {
    "Patente": e.patente,
    "Marca": e.marca,
    "Precio": e.precio
  };
  
  request.body = json.encode(mapaAuto); // string object
  // print(request.body);
  // debugPrint(request.body.toString());
  var mapaAutoDecoded = json.decode(request.body);
  // print(mapaAutoDecoded);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
  });
  
}

// postAuto(TextEditingController patente, String? marca, TextEditingController precio) async {
//   var mapaAuto = <String, dynamic>{}; //map object
//   var headers = {'Content-Type': 'application/json'};
//   var request = http.Request(
//     'POST',
//     Uri.parse('https://localhost:44337/api/Autos'),
//   );
//   mapaAuto = {
//     "Patente": patente.text,
//     "Marca": marca?.toString(),
//     "Precio": precio.text
//   };
  
//   request.body = json.encode(mapaAuto); // string object
//   // print(request.body);
//   // debugPrint(request.body.toString());
//   var mapaAutoDecoded = json.decode(request.body);
//   // print(mapaAutoDecoded);
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   } else {
//     print(response.reasonPhrase);
//   }
// }
