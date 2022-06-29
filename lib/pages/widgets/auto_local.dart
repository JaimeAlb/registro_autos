import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_autos/pages/clases/local_auto_class.dart';

class AutoLocal extends StatelessWidget {
  final _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
  final LocalAuto item;
  final Function selectHandler;
  AutoLocal(this.item, this.selectHandler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () => selectHandler(item),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
