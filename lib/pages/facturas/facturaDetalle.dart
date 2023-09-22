import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/facturas/profile_container.dart';
import 'package:mi_app_01/pages/facturas/profile_send_to.dart';
import 'package:mi_app_01/models/facturasDetalleModel.dart';
import 'package:mi_app_01/pages/facturas/facturas_menu_header.dart';
import 'package:http/http.dart' as http;
import 'package:mi_app_01/utils/constants.dart';
import 'total.dart';
import '../../utils/utils.dart';

int listaDataTotal = 0;
Header? inheader;
String displayText = "";
int _selectedIndex = 0;

class FacturaDetalle extends StatelessWidget {
  static const routeName = '/facturaDetalle';

  const FacturaDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as FacturaDetalleArguments;
    print(arg);

    return Scaffold(
        appBar: FacturasMenuHeader().getAppBar('Detalle de la Factura'),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

class FacturaDetallebody extends StatefulWidget {
  final int arg;
  const FacturaDetallebody({super.key, required this.arg});

  @override
  State<FacturaDetallebody> createState() => _FacturaDetallebodyState();
}

class _FacturaDetallebodyState extends State<FacturaDetallebody> {
  Util util = Util();
  Future<List<Detalle>>? detalleLista;
  String url = "";
  double total = 0;
  double itbis = 0;
  double subtotal = 0;
  double descuento = 0;

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
                return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => const Text('data'),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                        itemCount: 8));
              case ConnectionState.done:
                final posts = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      Text('data');
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
  const FacturaDetalleBody1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text("facturaId ${widget.facturaId}"),
        Expanded(
          child: FutureBuilder(
              future: detalleLista,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Detalle>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (listaDataTotal == 0) {
                      return const Center(
                        child: Text('No existe nada para mostrar'),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: listaDataTotal,
                          itemBuilder: (context, index) {
                            if (listaDataTotal == 0) {
                              return const Center(
                                child: Text('text'),
                              );
                            } else {
                              return Column(
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
                                            const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 10),
                                        visualDensity:
                                            const VisualDensity(vertical: 1),
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(snapshot.data![index].codigo
                                                .toString())
                                          ],
                                        ),
                                        title: Text(
                                          snapshot.data![index].descripcion,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(TextSpan(
                                                text: util.getCurrency(
                                                    snapshot.data![index]
                                                            .preciounitario ??
                                                        0,
                                                    false),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Colors.blueAccent),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          " x ${snapshot.data![index].cantidad}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal))
                                                ])),
                                            if (snapshot.data![index].descuento!
                                                    .toDouble() >
                                                0)
                                              Text(
                                                "-${util.getCurrency(snapshot.data![index].descuento ?? 0, false)}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                          ],
                                        ),
                                        trailing: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                util
                                                    .getCurrency(snapshot
                                                            .data![index]
                                                            .subtotal ??
                                                        0)
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            if (snapshot.data![index].itebis! >
                                                0)
                                              Text(
                                                'Itbis${util.getCurrency(snapshot.data![index].itebis ?? 0, false)}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )
                                          ],
                                        )),
                                  ),
                                ],
                              );
                            }
                          });
                    }
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              }),
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
  final int arguments;

  FacturaDetalleArguments({required this.arguments});
}
