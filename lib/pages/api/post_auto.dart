import 'dart:convert';
import 'package:http/http.dart' as http;

postAuto(String patente, String? marca, String precio) async {
  var mapaAuto = <String, dynamic>{}; //map object
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse('https://localhost:44337/api/Autos'),
    // Uri.parse('https://9d59-207-248-198-238.sa.ngrok.io/api/Autos'),
  );
  mapaAuto = {"Patente": patente, "Marca": marca?.toString(), "Precio": precio};

  request.body = json.encode(mapaAuto); // string object
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
