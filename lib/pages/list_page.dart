import 'package:flutter/material.dart';
import 'package:registro_autos/pages/api/post_auto_list.dart';
import 'package:registro_autos/pages/clases/listaAutos.dart';
// import 'package:registro_autos/pages/clases/listaMarcas.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:registro_autos/pages/clases/listaAutos2.dart';
import 'package:registro_autos/pages/clases/lista_autos3.dart';
import 'dart:convert';

import 'package:registro_autos/pages/global_list.dart';

import 'api/post_auto.dart';
import 'global.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

List<ListaAutos2> listaAutos2 = [];
Future<List<ListaAutos>> getListOfAutos() async {
  const String url = 'https://localhost:44337/api/Autos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // debugPrint(response.body);

    final listaAutos = listaAutosFromJson(response.body);
    // print(response.body);
    // listaAutos2 = listaAutosFromJson2(Global.mensaje);
    // print(Global.mensaje);

    return listaAutos;
  } else {
    throw Exception('Error!');
  }
}

class _ListPageState extends State<ListPage> {
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

  Widget listOfAutos(List<ListaAutos> listado) {
    List<Widget> listadoWidget = [];
    int i = 0;
    for (var item in listado) {
      i++;
      Widget obj = Container(
        width: 800,

        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        height: 120,
        color: i % 2 == 0 ? Color.fromARGB(255, 99, 91, 91) : Color.fromARGB(255, 121, 133, 136),
        child: Column(
          children: [
            
            Row(
              children: [
                const Text(
                  'Patente: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0),),
                ),
                Text(item.patente, style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0),),),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Marca: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item.marca,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Precio: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${formatCurrency.format(item.precio)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Borrar'),
              onPressed: () async {
                debugPrint(item.id.toString());
                var headers = {'Content-Type': 'application/json'};
                var request = http.Request(
                  'DELETE',
                  Uri.parse('https://localhost:44337/api/Autos/' +
                      item.id.toString()),
                );
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  setState(() {});
                } else {
                  print(response.reasonPhrase);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            )
          ],
        ),
      );
      listadoWidget.add(obj);
    }
    return Column(
      children: listadoWidget,
    );
  }
  Widget listOfAutos2(List<ListaAutos3> listado) {
    List<Widget> listadoWidget = [];
    int i = 0;
    for (var item in listado) {
      i++;
      Widget obj = Container(
        width: 800,

        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        height: 120,
        // color: i % 2 == 0 ? Color.fromARGB(255, 99, 91, 91) : Color.fromARGB(255, 121, 133, 136),
        color: Color.fromARGB(255, 122, 93, 5),
        child: Column(
          children: [
            
            Row(
              children: [
                const Text(
                  'Patente: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0),),
                ),
                Text(item.patente, style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0),),),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Marca: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item.marca,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Precio: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  // '${formatCurrency.format(item.precio)}',
                  item.precio,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Borrar'),
              onPressed: (){
                listado.remove(item);
                setState(() {
                  
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            )
          ],
        ),
      );
      listadoWidget.add(obj);
    }
    return Column(
      children: listadoWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Listado Autos App"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  GlobalList.globalList.forEach((e) {
                    postAuto(e.patente, e.marca, e.precio);
                  });
                  GlobalList.globalList = [];
                  print(GlobalList.globalList);

                  Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() {});
                  });
                },
                child: const Text('Update List')),
            Center(
              child: Column(
                children: [
                  FutureBuilder<List<ListaAutos>>(
                    future: getListOfAutos(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return listOfAutos(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  listOfAutos2(GlobalList.globalList)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
