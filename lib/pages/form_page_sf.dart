import 'package:flutter/material.dart';
import 'package:registro_autos/pages/api/marca_api.dart';
import 'package:registro_autos/pages/api/post_auto.dart';
import 'package:registro_autos/pages/clases/listaAutos.dart';
import 'package:registro_autos/pages/clases/listaAutos2.dart';
import 'package:registro_autos/pages/global_list.dart';
import 'package:registro_autos/pages/list_page.dart';
import 'clases/lista_autos3.dart';
import 'global.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormPageSF extends StatefulWidget {
  const FormPageSF({Key? key}) : super(key: key);

  @override
  State<FormPageSF> createState() => _FormPageSFState();
}

final TextEditingController _patenteController = TextEditingController();
// final TextEditingController _marcaController = TextEditingController();
String? _marcaController;
var lista1 = <ListaAutos3>[];
final TextEditingController _precioController = TextEditingController();
bool optionSelected = false;

class _FormPageSFState extends State<FormPageSF> {
  String hintTexto = 'Marca';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Registro Autos App"))),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text("PATENTE"),
                const SizedBox(height: 10),
                TextField(
                  controller: _patenteController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 40),
                const Text("MARCA"),
                const SizedBox(height: 10),
                Center(
                  child: TypeAheadField<Marca?>(
                    hideSuggestionsOnKeyboardHide: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: TextEditingController(text: (_marcaController)),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        // hintText: 'Buscar Marca',
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
                      setState(() {     
                      });
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: Text('Marca seleccionada: ${marca.name}'),
                        ));
                    },
                  ),
                ),
                const SizedBox(height: 40),
                const Text("PRECIO"),
                const SizedBox(height: 10),
                TextField(
                  controller: _precioController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  child: const Text("GUARDAR"),
                  onPressed: () {
                    if (GlobalList.globalList.length == 0) {lista1 = [];}
                    // postAuto(_patenteController, _marcaController,
                    //     _precioController);
                    var mapaAuto = {
                      "Patente": _patenteController.text,
                      "Marca": _marcaController?.toString(),
                      "Precio": _precioController.text
                    };
                    var stringAuto = json.encode(mapaAuto);
                    var jsonAuto = listaAutos3FromJson(stringAuto);
                    print(jsonAuto.marca);
                    lista1.add(jsonAuto);
                    GlobalList.globalList = lista1;
                    print(GlobalList.globalList);

                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  child: const Text("LISTADO"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListPage(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
