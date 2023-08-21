import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mi_app_01/presentation/screens/menu/menu_bottom.dart';
import '../../../models/gif.dart';
import 'package:money_formatter/money_formatter.dart';

import '../menu/menu_header.dart';
import '../../../pages/facturas/facturaDetalle.dart';

void main() => runApp(const Restfull());

class Restfull extends StatefulWidget {
  const Restfull({super.key});

  @override
  State<Restfull> createState() => _RestfullState();
}

class _RestfullState extends State<Restfull> {
  Future<List<Datum>>? listadoGifs;
  String url = "";
  int _selectedIndex = 1;

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

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  search(value) {}

  @override
  void initState() {
    super.initState();
    listadoGifs = getGifs();
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
                    onChanged: (text) {
                      search(text.toUpperCase());
                    },
                  ),
                ],
              ),
              Container(),
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
                              return Card(
                                margin: EdgeInsets.all(8.0),
                                elevation: 0.5,
                                child: ListTile(
                                    onTap: () {},
                                    contentPadding: const EdgeInsets.symmetric(
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(getDate(snapshot
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
                                    trailing: Text(getCurrency(2000).toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    enabled: snapshot.data![index].username
                                            .toString() !=
                                        ""),
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
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
          )),
    );
  }
}

getText(AsyncSnapshot<List<Datum>> snapshot, int index) {
  if (snapshot.data != null) {
    return snapshot.data![index].title.toString().trim().substring(0, 1);
  }
  return "hola";
}

String getCurrency(double value) {
  MoneyFormatter fmf = MoneyFormatter(
      amount: value,
      settings: MoneyFormatterSettings(
          symbol: 'RD\$',
          thousandSeparator: ',',
          decimalSeparator: '.',
          symbolAndNumberSeparator: '',
          fractionDigits: 2,
          compactFormatType: CompactFormatType.long));

  return fmf.output.symbolOnLeft;
}

String isNull(data) {
  if (data == 'null') {
    return '';
  }

  return data;
}

getDate(now) {
  String formattedDate = DateFormat('dd/MM/yyyy').format(now);

  return formattedDate;
}
