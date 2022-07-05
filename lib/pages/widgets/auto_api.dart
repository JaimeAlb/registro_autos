import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/pages/clases/auto_api_class.dart';

class AutoApi extends StatelessWidget {
  final AutoApiClass item;
  final Function setStateHandler;
  final _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
  AutoApi(this.item, this.setStateHandler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      height: 120,
      color: const Color.fromARGB(255, 99, 91, 91),
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
  }
}
