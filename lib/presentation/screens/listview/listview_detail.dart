import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_app_01/card/profile_container.dart';
import 'package:mi_app_01/card/profilepage.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_bottom.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_header.dart';
import 'package:http/http.dart' as http;
import '../../../models/Gif.dart';
import '../../../utils/utils.dart';

class Details extends StatefulWidget {
  final String numeroFactura;

  const Details({super.key, required this.numeroFactura});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Util util = Util();
  Future<List<Datum>>? listadoGifs;
  String url = "";
  int _selectedIndex = 0;

  Future<List<Datum>> getGifs() async {
    Gif? list;
    List<Datum>? listDatum = [];

    String url =
        "https://api.giphy.com/v1/gifs/trending?api_key=K7Ear4ZUaTO32x0OdsI181JV1iQqAmro&limit=25&offset=0&rating=g&bundle=messaging_non_clips";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);
        list = Gif.fromJson(jsonData);

        for (Datum item in list.data) {
          listDatum.add(item);
          print(item);
        }
      } catch (e) {
        print(e);
      }
    }

    return listDatum;
  }

  @override
  void initState() {
    super.initState();
    listadoGifs = getGifs();
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuHeader().getAppBar('Detalle de la Factura'),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: listadoGifs,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Datum>> snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index == 0)
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ProfileContainer()),
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
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Details(
                                                  numeroFactura: snapshot
                                                      .data![index].username
                                                      .toString()),
                                            ));
                                      },
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 10),
                                      visualDensity:
                                          const VisualDensity(vertical: 1),
                                      leading: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [Text('78547')],
                                      ),
                                      title: Text(
                                        snapshot.data![index].title.toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(util.formatDate(snapshot
                                              .data![index].importDatetime)),
                                          Text(
                                            snapshot.data![index].username
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                          util.getCurrency(2000).toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      enabled: snapshot.data![index].username
                                              .toString() !=
                                          ""),
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
