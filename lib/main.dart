import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/counters/login.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_2.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Titulo",
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/listview_2': (context) => const Listview2(),
        '/detail/': (context) => const Details(),
      },
      // home: CounterScreen()
    );
  }
}
