import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../2_form_page_sf.dart';

postLogin(TextEditingController nombre, TextEditingController password,
    context) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse('http://localhost:53688/Login'));
  request.body = json.encode({
    "Username": nombre.text,
    "Password": password.text,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FormPageSF(),
        ));
  } else {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text('Intente Nuevamente'),
      ));
  }
}
