import 'package:flutter/material.dart';
import '/pages/api/post_login.dart';

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
              onPressed: () =>
                  postLogin(_nombreController, _passwordController, context),
            ),
          ],
        ),
      ),
    );
  }
}
