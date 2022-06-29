import 'package:flutter/material.dart';
import 'package:registro_autos/pages/clases/auto_api_class.dart';
import 'package:http/http.dart' as http;
import 'package:registro_autos/pages/clases/local_auto_class.dart';
import 'package:registro_autos/pages/global_list.dart';
import 'package:registro_autos/pages/widgets/auto_api.dart';
import 'package:registro_autos/pages/widgets/auto_local.dart';
import 'api/post_auto.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<LocalAuto> listFromGlobal = GlobalList.globalList;

  void _eraseItemFromLocal(item) {
    setState(() {
      GlobalList.globalList.remove(item);
    });
  }

  void _eraseItemFromApi(item) async {
    debugPrint(item.id.toString());
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'DELETE',
      Uri.parse('https://localhost:44337/api/Autos/' + item.id.toString()),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {});
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  Future<List<AutoApiClass>> getListOfAutosFromApi() async {
    const String url = 'https://localhost:44337/api/Autos';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<AutoApiClass> listaAutos = listaAutosFromJson(response.body);

      return listaAutos;
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('listFromGlobal, $listFromGlobal');
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
                  FutureBuilder<List<AutoApiClass>>(
                    future: getListOfAutosFromApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            ...(snapshot.data!)
                                .map((item) => AutoApi(item, _eraseItemFromApi))
                                .toList()
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  ...(GlobalList.globalList).map((auto) {
                    return AutoLocal(auto, _eraseItemFromLocal);
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
