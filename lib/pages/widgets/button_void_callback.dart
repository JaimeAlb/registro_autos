import 'package:flutter/material.dart';

class ButtonVoidCallback extends StatelessWidget {
  final VoidCallback selectHandler;
  final String name;
  const ButtonVoidCallback(this.selectHandler, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => selectHandler(),
      child: Text(name),
    );
  }
}
