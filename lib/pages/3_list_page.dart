import 'package:flutter/material.dart';
import 'package:registro_autos/pages/clases/lista_autos.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:registro_autos/pages/clases/local_auto.dart';
import 'package:registro_autos/pages/global_list.dart';
import 'api/post_auto.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future<List<ListaAutos>> getListOfAutosFromApi() async {
    const String url = 'https://localhost:44337/api/Autos';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // final listaAutos = listaAutosFromJson(response.body);
      List<ListaAutos> listaAutos = listaAutosFromJson(response.body);

      return listaAutos;
    } else {
      throw Exception('Error!');
    }
  }

  
  Widget listOfAutosFromApi(List<ListaAutos> listado) {
  final _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
    var _listadoWidget = <Widget>[];
    var i = 0;
    for (var item in listado) {
      i++;
      Widget obj = Container(
        width: 800,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        height: 120,
        color: i % 2 == 0
            ? const Color.fromARGB(255, 99, 91, 91)
            : const Color.fromARGB(255, 121, 133, 136),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Patente: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  item.patente,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
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
                  _formatCurrency.format(item.precio),
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
                  debugPrint(response.reasonPhrase);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            )
          ],
        ),
      );
      _listadoWidget.add(obj);
    }
    return Column(
      children: _listadoWidget,
    );
  }

  Widget listOfAutosFromLocal(List<LocalAuto> listado) {
  final _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
    var _listadoWidget = <Widget>[];
    for (var item in listado) {
      Widget obj = Container(
        width: 800,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        height: 120,
        color: const Color.fromARGB(255, 122, 93, 5),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Patente: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  item.patente,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
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
                  _formatCurrency.format(int.parse(item.precio)),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('Borrar'),
              onPressed: () {
                listado.remove(item);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            )
          ],
        ),
      );
      _listadoWidget.add(obj);
    }
    return Column(
      children: _listadoWidget,
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
                  for (var e in GlobalList.globalList) {
                    postAuto(e.patente, e.marca, e.precio);
                  }
                  GlobalList.globalList = [];
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {});
                  });
                },
                child: const Text('Update List')),
            Center(
              child: Column(
                children: [
                  FutureBuilder<List<ListaAutos>>(
                    future: getListOfAutosFromApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return listOfAutosFromApi(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  listOfAutosFromLocal(GlobalList.globalList)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
