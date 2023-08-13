import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/api/restfull.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_detail.dart';
import 'package:mi_app_01/push/push.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Push());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Titulo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Details(
          numeroFactura: '',
        ));
  }
}
