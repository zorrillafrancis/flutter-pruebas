import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  const MensajePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('mensaje page'),
      ),
      body: Center(child: Text('Mensaje ' + arg.toString())),
    );
  }
}
