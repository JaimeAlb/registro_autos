import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldPatente extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final String hintText;
  const TextFieldPatente(this.name, this.controller, this.hintText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
      mask: 'AAAA-##',
    );
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(name),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), hintText: hintText),
          inputFormatters: [
            maskFormatter,
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
