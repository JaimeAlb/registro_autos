import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clases/lista_autos.dart';

Widget listOfAutosFromApi(List<ListaAutos> listado, Function setStateHandler) {
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
            onPressed: () => setStateHandler(item),
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
