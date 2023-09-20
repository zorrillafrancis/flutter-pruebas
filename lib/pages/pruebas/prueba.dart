import 'package:flutter/material.dart';

class Prueba extends StatefulWidget {
  static String routeName = "/prueba";
  const Prueba({super.key});

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('data'));
  }
}
