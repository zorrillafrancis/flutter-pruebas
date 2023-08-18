import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? userLogin;

class Bienvenida extends StatefulWidget {
  const Bienvenida({super.key});

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  Future<String> getData() async {
    if (kDebugMode) {
      print('object');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? "";

    return userName;
  }

  @override
  void initState() async {
    super.initState();
    userLogin = await getData();
    print(userLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sx'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.school),
            onPressed: () {},
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Bienvenido $userLogin',
                    style:
                        const TextStyle(fontFamily: 'RobotoMono', fontSize: 20),
                  ),
                ),
                const SizedBox(height: 150),
                SizedBox(
                    width: 160, // <-- Your width
                    height: 100, // <-- Your height
                    child: ElevatedButton.icon(
                      label: const Text('Facturas'),
                      icon: const Icon(Icons.receipt),
                      onPressed: () {
                        /*  Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const Listview2();
                    }));*/
                        Navigator.pushNamed(context, 'facturaListado');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.lightBlue,
                        fixedSize: const Size(170, 40),
                      ),
                    ))
              ],
            ),
          ],
        ));
  }
}

class Empresa {
  String nombre = "";
  String propietario = "";
  int ingreso = 0;

  Empresa(String nombre, String propietario, int ingreso);
}
