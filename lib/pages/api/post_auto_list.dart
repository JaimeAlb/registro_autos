// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../clases/local_auto.dart';

// postAutoList(List<LocalAuto> listado) {
//   var mapaAuto = <String, dynamic>{}; //map object
//   var headers = {'Content-Type': 'application/json'};
//   var request = http.Request(
//     'POST',
//     Uri.parse('https://localhost:44337/api/Autos'),
//   );
//   listado.map((e) async {
//     mapaAuto = {"Patente": e.patente, "Marca": e.marca, "Precio": e.precio};

//     request.body = json.encode(mapaAuto); // string object
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   });
// }
