import 'package:flutter/material.dart';

class Usuarios extends StatelessWidget {
  const Usuarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.pink),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Text('usuarios'),
        ));
  }
}
