import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mi_app_01/components/loading_list.dart';
import 'package:mi_app_01/pages/factura_detalle/factura_profile_container.dart';
import 'package:mi_app_01/pages/factura_detalle/factura_profile_send_to.dart';
import 'package:mi_app_01/models/facturasDetalleModel.dart';
import 'package:mi_app_01/pages/factura_detalle/factura_total.dart';
import 'package:mi_app_01/pages/facturas/facturas_menu_header.dart';
import 'package:http/http.dart' as http;
import 'package:mi_app_01/utils/constants.dart';
import '../../utils/utils.dart';

int listaDataTotal = 0;
Header? inheader;
String displayText = "";
Util util = Util();
double total = 0;
double? itbis = 0;
double? subtotal = 0;
double? descuento = 0;

class FacturaDetalle extends StatefulWidget {
  static const routeName = '/facturaDetalle';

  const FacturaDetalle({super.key});

  @override
  State<FacturaDetalle> createState() => _FacturaDetalleState();
}

class _FacturaDetalleState extends State<FacturaDetalle> {
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as FacturaDetalleArguments;

    return Scaffold(
      appBar: FacturasMenuHeader().getAppBar('Detalle de la Factura'),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          FacturaDetallebody(
            arg: arg.facturaId,
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15))
          ]),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  util.getCurrency(total),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              const Spacer(),
              Container(
                height: 60,
                width: 150,
                alignment: Alignment.center,
                child: const Text(
                  "Ver Detalle",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueAccent),
                ),
              ),
            ],
          )),
    );
  }
}

class FacturaDetallebody extends StatefulWidget {
  final int arg;
  const FacturaDetallebody({super.key, required this.arg});

  @override
  State<FacturaDetallebody> createState() => _FacturaDetallebodyState();
}

class _FacturaDetallebodyState extends State<FacturaDetallebody> {
  Future<List<Detalle>>? detalleLista;
  String url = "";

  Future<List<Detalle>>? loadData() async {
    List<Detalle> list = [];
    String url =
        "${Environment.apiUrl}/Facturas/GetDetalleById?id=${widget.arg}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);
        var data = jsonData['value'];

        inheader = Header.fromJson(data['header']);
        list =
            List<Detalle>.from(data['detalle'].map((x) => Detalle.fromJson(x)));
      } catch (e) {
        print(e);
      }
    }

    listaDataTotal = list.length;
    return list;
  }

  @override
  void initState() {
    super.initState();
    detalleLista = loadData();

    detalleLista!.then((value) {
      print('then');
      print(value);
      double totalIn = 0;

      for (Detalle item in value) {
        totalIn += (item.subtotal ?? 0);
        print(totalIn);
      }

      setState(() {
        total = 45;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: detalleLista,
          builder:
              (BuildContext context, AsyncSnapshot<List<Detalle>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return ListView.separated(
                    itemBuilder: (context, index) => const LoadingList(),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                    itemCount: 8);
              case ConnectionState.done:
                if (snapshot.data!.length == 0) {
                  return const Center(
                    child: Text('No existe información para mostrar'),
                  );
                }

                final posts = snapshot.data!;

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return FacturaDetalleBody1(
                          detalle: posts[index], index: index);
                    });

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }
}

class FacturaDetalleBody1 extends StatelessWidget {
  final Detalle detalle;
  final int index;
  const FacturaDetalleBody1(
      {super.key, required this.detalle, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            if (index == 0)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileContainer(
                    header: inheader,
                  )),
            if (index == 0)
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProfileSendTo(
                    text: 'enviado a ',
                  )),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 0.5,
              child: ListTile(
                  onTap: () {},
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  visualDensity: const VisualDensity(vertical: 1),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(detalle.codigo.toString())],
                  ),
                  title: Text(
                    detalle.descripcion,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                          text: util.getCurrency(
                              detalle.preciounitario ?? 0, false),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.blueAccent),
                          children: [
                            TextSpan(
                                text: " x ${detalle.cantidad}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal))
                          ])),
                      if (detalle.descuento!.toDouble() > 0)
                        Text(
                          "-${util.getCurrency(detalle.descuento ?? 0, false)}",
                          style: const TextStyle(
                              fontSize: 12, fontStyle: FontStyle.italic),
                        )
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(util.getCurrency(detalle.subtotal ?? 0).toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      if (detalle.itebis! > 0)
                        Text(
                          'Itbis${util.getCurrency(detalle.itebis ?? 0, false)}',
                          style: const TextStyle(
                              fontSize: 12, fontStyle: FontStyle.italic),
                        )
                    ],
                  )),
            ),
          ],
        ),
      ],
    );
  }
}

getText(TextEditingController ctrl, String labelText, Icon suffixIcon) {
  return TextField(
    enabled: false,
    controller: ctrl,
    decoration: InputDecoration(
        labelText: labelText.toString(),
        suffixIcon: suffixIcon,
        fillColor: const Color.fromARGB(31, 219, 9, 9),
        border: const OutlineInputBorder(),
        filled: false),
    onChanged: (text) {},
  );
}

getTextForm(TextEditingController ctrl, String labelText, Icon suffixIcon) {
  return TextFormField(
    enabled: false,
    controller: ctrl,
    decoration: InputDecoration(
        labelText: labelText.toString(),
        suffixIcon: suffixIcon,
        isDense: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black))),
  );
}

class FacturaDetalleArguments {
  final int facturaId;

  FacturaDetalleArguments({required this.facturaId});
}
