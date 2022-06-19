import 'package:flutter/material.dart';
import 'package:registro_autos/pages/api/marca_api.dart';
import 'package:registro_autos/pages/global_list.dart';
import 'package:registro_autos/pages/list_page.dart';
import 'package:registro_autos/pages/widgets/text_field.dart';
import 'clases/local_auto.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';

class FormPageSF extends StatefulWidget {
  const FormPageSF({Key? key}) : super(key: key);

  @override
  State<FormPageSF> createState() => _FormPageSFState();
}

final TextEditingController _patenteController = TextEditingController();
String? _marcaController;
final TextEditingController _precioController = TextEditingController();
var autosLocalList = <LocalAuto>[];

class _FormPageSFState extends State<FormPageSF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Registro Autos App"))),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                textFieldPatente("PATENTE", _patenteController, "DTFJ-19"),
                const Text("MARCA"),
                const SizedBox(height: 10),
                TypeAheadField<Marca?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: TextEditingController(text: (_marcaController)),
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
                    _marcaController = marca.name;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Marca seleccionada: ${marca.name}'),
                      ));
                  },
                ),
                textFieldPrecio("PRECIO", _precioController, "\$10.000.000"),
                ElevatedButton(
                  child: const Text("GUARDAR"),
                  onPressed: () {
                    debugPrint(_patenteController.text);
                    debugPrint(_precioController.text);
                    String precioControllerClean = _precioController.text;
                    precioControllerClean = precioControllerClean.replaceAll(RegExp('[^0-9]'), '');
                    debugPrint(precioControllerClean);
                    
                    if (GlobalList.globalList.isEmpty) {
                      autosLocalList = [];
                    }
                    var mapaAuto = {
                      "Patente": _patenteController.text,
                      "Marca": _marcaController?.toString(),
                      "Precio": precioControllerClean
                    };
                    var stringAuto = json.encode(mapaAuto);
                    var jsonAuto = localAutoFromJson(stringAuto);
                    autosLocalList.add(jsonAuto);
                    GlobalList.globalList = autosLocalList;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  child: const Text("LISTADO"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListPage(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
