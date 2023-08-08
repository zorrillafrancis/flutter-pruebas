import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/api/restfull.dart';
import 'package:mi_app_01/presentation/screens/counters/login.dart';
import 'package:mi_app_01/presentation/screens/personas/listPerson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Titulo",
      home: Restfull(),
    );
  }
}
