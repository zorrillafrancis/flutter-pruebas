import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mi_app_01/models/facturasM.dart';
import 'package:mi_app_01/utils/size_config.dart';
import 'package:mi_app_01/utils/constants.dart';
import '../../utils/constants.dart';
import '../../presentation/screens/api/restfull.dart';
import 'facturaDetalle.dart';
import '../../presentation/screens/menu/menu_header.dart';

Future<List<Facturas>>? listaData;

class FacturasListado extends StatefulWidget {
  static String routeName = "/facturaListado";
  const FacturasListado({super.key});

  @override
  State<FacturasListado> createState() => _FacturasListadoState();
}

class _FacturasListadoState extends State<FacturasListado> {
  Future<List<Facturas>> loadData() async {
    List<Facturas> dataFactura = [];

    String url = "${Environment.apiUrl}/Facturas?pkidEmpresa=1&isCliente=0";

    var body = {
      "numero_factura": "",
      "fechaDesde": "2023-08-15T18:46:00.660Z",
      "fechaHasta": "2023-08-17T18:46:00.660Z"
    };

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);

        for (dynamic item in jsonData['value']) {
          Facturas f = Facturas(
              item['id'],
              item['numeroFactura'],
              item['fecha'] = DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(item['fecha'])),
              item['nombre'],
              item['pkidcliente'],
              item['tiempoentrega'],
              item['itebis'],
              item['total'] = getCurrency(item['total'] ?? 0),
              item['emailcliente'],
              item['cotizacion'],
              item['pkidempresa'],
              item['pkidsuplidorInformar'],
              item['itbisPorc'] == null ? null : checkDouble(item['itbisPorc']),
              item['pkidestatus'],
              item['recibo'],
              item['pkidcompaniaEnvio'],
              item['usuario']);

          dataFactura.add(f);
        }
      } catch (e) {
        print(e);
      }
    }

    return dataFactura;
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  @override
  void initState() {
    super.initState();
    listaData = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MenuHeader().getAppBar('Facturas'),
      body: SafeArea(
        child: Column(
          children: [
            FacturasHeader(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: listaData,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Facturas>> snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(snapshot.data![index].id.toString()),
                              background: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                    color: Colors.blueAccent),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                              child: Card(
                                margin: EdgeInsets.all(8.0),
                                elevation: 0.5,
                                child: ListTile(
                                    onTap: () {
                                      print('click');
                                      print(snapshot.data![index].id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Details(
                                                facturaId:
                                                    snapshot.data![index].id),
                                          ));
                                      /*    Navigator.pushNamed(
                                          context, 'facturaDetalle',
                                          arguments: 48);*/
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    visualDensity:
                                        const VisualDensity(vertical: 1),
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data![index].numeroFactura
                                            .toString())
                                      ],
                                    ),
                                    title: Text(
                                      snapshot.data![index].nombre.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].fecha),
                                        Text(
                                          snapshot.data![index].usuario
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    trailing: Text(snapshot.data![index].total,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    enabled: snapshot.data![index].pkidestatus
                                            .toString() !=
                                        ""),
                              ),
                              onDismissed: (value) {},
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class FacturasHeader extends StatelessWidget {
  const FacturasHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(10),
              horizontal: getProportionateScreenWidth(10)),
          child: TextField(
              decoration: InputDecoration(
            labelText: 'Buscar',
            suffixIcon: const Icon(Icons.search),
            hintText: 'Buscar',
            fillColor: const Color.fromARGB(31, 240, 234, 234),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(color: kTextColor),
                gapPadding: 1),
          )),
        ),
      ],
    );
  }
}
