import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/provider/chatProvider.dart';
import '../../utils/message.dart';
import 'banner_bienvenida.dart';
import 'catergories.dart';

String? userName;

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

    return prefs.getString('userName') ?? "";
  }

  @override
  void initState() {
    super.initState();
    getData().then((e) {
      setState(() {
        userName = e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                const SizedBox(height: 50),
                BannerBienvenida(width: width),
                const SizedBox(height: 20),
                const Categories(),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              backgroundColor: Colors.lightBlue,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shadowColor: Colors.lightBlue,
                              fixedSize: const Size(170, 40),
                            ),
                          )),
                      const SizedBox(width: 15),
                      SizedBox(
                          width: 160, // <-- Your width
                          height: 100, // <-- Your height
                          child: ElevatedButton.icon(
                            label: const Text('Usuarios'),
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              print('===== Usuarios =====');
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              backgroundColor: Colors.pink,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shadowColor: Colors.pink,
                              fixedSize: const Size(170, 40),
                            ),
                          )),
                    ]),
                const SizedBox(height: 50),
                SizedBox(
                    width: 160, // <-- Your width
                    height: 100, // <-- Your height
                    child: ElevatedButton.icon(
                      label: const Text('Mantenimiento'),
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.orange,
                        fixedSize: const Size(170, 40),
                      ),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ));
  }
}
