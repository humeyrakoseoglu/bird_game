import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Barrier({this.size});

  // ignore: prefer_typing_uninitialized_variables
  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green[300],
          border: Border.all(
              width: 10, color: const Color.fromARGB(255, 89, 141, 92)),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
