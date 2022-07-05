import 'package:flutter/material.dart';
import '/pages/global_list.dart';
import '/pages/3_list_page.dart';
import '/pages/widgets/button_void_callback.dart';
import '/pages/widgets/text_field_patente.dart';
import '/pages/widgets/text_field_precio.dart';
import '/pages/widgets/type_ahead_marca.dart';
import 'clases/local_auto_class.dart';
import 'dart:convert';

class FormPageSF extends StatefulWidget {
  const FormPageSF({Key? key}) : super(key: key);
  @override
  State<FormPageSF> createState() => _FormPageSFState();
}

class _FormPageSFState extends State<FormPageSF> {
  final TextEditingController patenteController = TextEditingController();
  String? marcaController;
  final TextEditingController precioController = TextEditingController();
  var _autosLocalList = <LocalAuto>[];

  void _guardarAuto() {
    String precioControllerClean = precioController.text;
    precioControllerClean =
        precioControllerClean.replaceAll(RegExp('[^0-9]'), '');

    if (GlobalList.globalList.isEmpty) {
      _autosLocalList = [];
    }
    var mapaAuto = {
      "Patente": patenteController.text,
      "Marca": marcaController?.toString(),
      "Precio": precioControllerClean
    };
    var stringAuto = json.encode(mapaAuto);
    var jsonAuto = localAutoFromJson(stringAuto);
    _autosLocalList.add(jsonAuto);
    GlobalList.globalList = _autosLocalList;
  }

  void _showListado() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ListPage(),
        ));
  }

  void _marcaSelected(suggestion) {
    marcaController = suggestion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Registro Autos App"))),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFieldPatente("PATENTE", patenteController, "DTFJ-19"),
                const Text("MARCA"),
                const SizedBox(height: 10),
                TypeAheadMarca(_marcaSelected, marcaController),
                TextFieldPrecio("PRECIO", precioController, "\$10.000.000"),
                ButtonVoidCallback(_guardarAuto, "GUARDAR"),
                const SizedBox(height: 40),
                ButtonVoidCallback(_showListado, "LISTADO"),
              ],
            ),
          ),
        ));
  }
}
