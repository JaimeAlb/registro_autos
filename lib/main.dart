import 'package:flutter/material.dart';
import '/pages/2_form_page_sf.dart';
import 'pages/1_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro Autos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: LoginPage(),
      // home: FormPageSF(),
      // home: Prueba(),
    );
  }
}
