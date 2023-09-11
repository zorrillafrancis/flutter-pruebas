import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mi_app_01/constants.dart';
import 'package:mi_app_01/models/productos.dart';
import 'package:mi_app_01/pages/facturas/facturasListado.dart';
import 'package:mi_app_01/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/icon_btn_with_counter.dart';
import '../../components/popular_product.dart';
import '../../components/search_field.dart';
import '../../components/section_title.dart';
import 'banner_bienvenida.dart';
import 'catergories.dart';

String? userName;

class Bienvenida extends StatefulWidget {
  static String routeName = "/bienvenida";

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
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Search_field(),
                IconBtnWithCounter(
                  svgSrc: "lib/assets/icons/Cart Icon.svg",
                  numOfItems: 0,
                  press: () {},
                ),
                IconBtnWithCounter(
                  svgSrc: "lib/assets/icons/Bell.svg",
                  numOfItems: 2,
                  press: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          BannerBienvenida(width: width),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          PopularProducts(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Facturas_Botones(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Facturas_Botones_2()
        ],
      ),
    )));
  }
}

class Facturas_Botones extends StatelessWidget {
  const Facturas_Botones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 160, // <-- Your width
              height: 100, // <-- Your height
              child: ElevatedButton.icon(
                label: const Text('Facturas'),
                icon: const Icon(Icons.receipt),
                onPressed: () {
                  Navigator.pushNamed(context, FacturasListado.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.pink,
                  fixedSize: const Size(170, 40),
                ),
              )),
        ]);
  }
}

class Facturas_Botones_2 extends StatelessWidget {
  const Facturas_Botones_2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
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
              ))
        ]);
  }
}
