import 'package:flutter/material.dart';
import 'package:registro_autos/pages/form_page_sf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Registro Autos App"))),
      body: getbody(context),
    );
  }

  Widget getbody(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text("NOMBRE USUARIO"),
            const SizedBox(height: 10),
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 40),
            const Text("PASSWORD"),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text("ACCEDER"),
              onPressed: () async {
                var headers = {'Content-Type': 'application/json'};
                var request = http.Request(
                    'POST', Uri.parse('http://localhost:53688/Login'));
                request.body = json.encode({
                  "Username": _nombreController.text,
                  "Password": _passwordController.text,
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
              },     
            ),
          ],
        ),
      ),
    );
  }
}
