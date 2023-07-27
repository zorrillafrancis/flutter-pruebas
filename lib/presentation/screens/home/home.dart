import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/usuarios/usuarios.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Titulo',
          style: TextStyle(backgroundColor: Colors.pink),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              'When the exception was thrown, this was the stack When the exception was thrown, this was the stack When the  When the exception was thrown, this was the stack When the exception was thrown, this was the stack When the exception was thrown, this was the stackWhen the exception was thrown, this was the stackWhen the exception was thrown, this was the stackWhen the exception was thrown, this was the stack',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.send),
              label: const Text(
                "Aceptar",
                style: TextStyle(fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15))),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Usuarios(),
                    ));
              },
              icon: const Icon(Icons.send),
              label: const Text(
                "Aceptar",
                style: TextStyle(fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15))),
        ],
      ),
    );
  }
}
