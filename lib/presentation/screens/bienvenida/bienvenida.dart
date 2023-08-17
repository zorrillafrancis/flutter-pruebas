import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

Directory? rootDir;
late String tempDir;

class Bienvenida extends StatefulWidget {
  final String usuario;
  final String password;

  const Bienvenida({super.key, required this.usuario, required this.password});

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  Empresa emp = Empresa('nombre', 'propietario', 500);

  setData() async {
    if (kDebugMode) {
      print('object');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userName', widget.usuario);
    prefs.setString('userPass', widget.password);
  }

  @override
  void initState() {
    super.initState();
    print(emp.nombre);
  }

  @override
  Widget build(BuildContext context) {
    setData();

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
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20),
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
