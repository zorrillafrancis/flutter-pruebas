import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_app_01/card/profile_container.dart';
import 'package:mi_app_01/card/profilepage.dart';
import 'package:mi_app_01/models/facturasDetalleModel.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_bottom.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_header.dart';
import 'package:http/http.dart' as http;
import 'package:mi_app_01/utils/constants.dart';
import '../../models/facturasListadoModel.dart';
import '../../models/gif.dart';
import '../../utils/utils.dart';

Future<List<Detalle>>? listaData;
int listaDataTotal = 0;
Header? inheader;

class Details extends StatefulWidget {
  final int facturaId;

  const Details({super.key, required this.facturaId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Util util = Util();
  Future<List<Detalle>>? detalleLista;
  String url = "";
  int _selectedIndex = 0;

  Future<List<Detalle>> loadData() async {
    List<Detalle> list = [];
    String url =
        "${Environment.apiUrl}/Facturas/GetDetalleById?id=${widget.facturaId}";

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

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.facturaId);

    return Scaffold(
        appBar: MenuHeader().getAppBar('Detalle de la Factura'),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: loadData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Detalle>> snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: listaDataTotal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index == 0)
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ProfileContainer(
                                        header: inheader,
                                      )),
                                if (index == 0)
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ProfilePage(
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
                                          Text(
                                              "${snapshot.data![index].cantidad} x ${util.getCurrency(snapshot.data![index].preciounitario ?? 0, false)}"),
                                          if (snapshot.data![index].descuento!
                                                  .toDouble() >
                                              0)
                                            Text(
                                              "-${util.getCurrency(snapshot.data![index].descuento ?? 0, false)}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic),
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
                                                  fontWeight: FontWeight.w500)),
                                          if (snapshot.data![index].itebis! > 0)
                                            Text(
                                              'Itbis${util.getCurrency(snapshot.data![index].itebis ?? 0, false)}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic),
                                            )
                                        ],
                                      )),
                                ),
                              ],
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
        bottomNavigationBar: menuBottomBar());
  }

  BottomNavigationBar menuBottomBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.blue[500],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.business),
          label: 'Facturas',
          backgroundColor: Colors.blue[500],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: 'School',
          backgroundColor: Colors.blue[500],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Configuración',
          backgroundColor: Colors.blue[500],
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
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
