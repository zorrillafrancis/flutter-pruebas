import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mi_app_01/models/facturasListadoModel.dart';

import '../../presentation/screens/api/restfull.dart';
import 'facturaDetalle.dart';
import '../../presentation/screens/menu/menu_header.dart';

Future<List<Value>>? listaData;

class FacturasListado extends StatefulWidget {
  const FacturasListado({super.key});

  @override
  State<FacturasListado> createState() => _FacturasListadoState();
}

class _FacturasListadoState extends State<FacturasListado> {
  Future<List<Value>> loadData() async {
    List<Value> listaData = [];

    String url =
        "https://uniformes.schoolsolutionscrm.com/api/Facturas?pkidEmpresa=1&isCliente=0";

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
          Value m = Value.fromJson(item);
          listaData.add(m);
        }
      } catch (e) {
        print(e);
      }
    }

    return listaData;
  }

  @override
  void initState() {
    super.initState();
    listaData = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MenuHeader().getAppBar('Facturas'),
        body: Column(
          children: [
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Buscar',
                      fillColor: Color.fromARGB(31, 240, 234, 234),
                      filled: true),
                  onChanged: (text) {},
                ),
              ],
            ),
            Container(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: listaData,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Value>> snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(8.0),
                              elevation: 0.5,
                              child: ListTile(
                                  onTap: () {
                                    print('click');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Details(
                                              numeroFactura: snapshot
                                                  .data![index].id
                                                  .toString()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data![index].numeroFactura
                                          .toString())
                                    ],
                                  ),
                                  title: Text(
                                    snapshot.data![index].nombre.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          getDate(snapshot.data![index].fecha)),
                                      Text(
                                        snapshot.data![index].usuario
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                      getCurrency(
                                          snapshot.data![index].total ?? 0),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  enabled: snapshot.data![index].pkidestatus
                                          .toString() !=
                                      ""),
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
