import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldPrecio extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final String hintText;
  const TextFieldPrecio(this.name, this.controller, this.hintText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(name),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), hintText: hintText),
          inputFormatters: <TextInputFormatter>[
            CurrencyTextInputFormatter(
              decimalDigits: 0,
              symbol: '\$ ',
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
