import 'package:flutter/material.dart';
import 'package:registro_autos/pages/api/marca_api.dart';
import 'package:registro_autos/pages/global_list.dart';
import 'package:registro_autos/pages/3_list_page.dart';
import 'package:registro_autos/pages/widgets/button_void_callback.dart';
import 'package:registro_autos/pages/widgets/text_field_patente.dart';
import 'package:registro_autos/pages/widgets/text_field_precio.dart';
import 'clases/local_auto.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  var autosLocalList = <LocalAuto>[];
  // List<LocalAuto> globalLista = [  ];

  void _guardarAuto() {
    String precioControllerClean = precioController.text;
    precioControllerClean =
        precioControllerClean.replaceAll(RegExp('[^0-9]'), '');

    if (GlobalList.globalList.isEmpty) {
      autosLocalList = [];
    }
    var mapaAuto = {
      "Patente": patenteController.text,
      "Marca": marcaController?.toString(),
      "Precio": precioControllerClean
    };
    var stringAuto = json.encode(mapaAuto);
    var jsonAuto = localAutoFromJson(stringAuto);
    autosLocalList.add(jsonAuto);
    GlobalList.globalList = autosLocalList;
  }

  void _showListado() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ListPage(),
        ));
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
                TypeAheadField<Marca?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: TextEditingController(text: (marcaController)),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Buscar Marca',
                    ),
                  ),
                  suggestionsCallback: UserApi.getUserSuggestions,
                  itemBuilder: (context, Marca? suggestion) {
                    final user = suggestion!;

                    return ListTile(
                      title: Text(user.name),
                    );
                  },
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Marca no encontrada',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (Marca? suggestion) {
                    final marca = suggestion!;
                    marcaController = marca.name;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Marca seleccionada: ${marca.name}'),
                      ));
                  },
                ),
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
