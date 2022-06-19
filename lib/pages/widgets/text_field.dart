import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


Widget textFieldPatente(String name, TextEditingController controllerText, String hint) {
  var maskFormatter = MaskTextInputFormatter(
    mask: 'AAAA-##',
    // mask: 'AAAAAAA',
  );
  return Column(
    children: [
      const SizedBox(height: 40),
      Text(name),
      const SizedBox(height: 10),
      TextField(
        controller: controllerText,
        decoration: InputDecoration(border: const OutlineInputBorder(), hintText: hint),
        inputFormatters: [
         maskFormatter,
        ],
        
      ),
      const SizedBox(height: 40),
    ],
  );
}
Widget textFieldPrecio(String name, TextEditingController controllerText, String hint) {
  // final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter();
  // var maskFormatter = MaskTextInputFormatter(
  //   mask: '\$',
  // );
  return Column(
    children: [
      const SizedBox(height: 40),
      Text(name),
      const SizedBox(height: 10),
      TextField(
        controller: controllerText,
        decoration:
            InputDecoration(border: const OutlineInputBorder(), hintText: hint),
        inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter(
                // locale: 'cl',
                decimalDigits: 0,
                symbol: '\$ ',
              ),
            ],
      ),
      const SizedBox(height: 40),
    ],
  );
}
