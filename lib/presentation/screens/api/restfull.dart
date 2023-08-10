import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../models/gif.dart';
import 'package:money_formatter/money_formatter.dart';

void main() => runApp(const Restfull());

class Restfull extends StatefulWidget {
  const Restfull({super.key});

  @override
  State<Restfull> createState() => _RestfullState();
}

class _RestfullState extends State<Restfull> {
  Future<List<Datum>>? listadoGifs;
  String url = "";

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Text('Hey'),
                FutureBuilder(
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
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                elevation: 0.4,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shadowColor: Colors.red,
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
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Text('Some text');
                    })
              ],
            ),
          ),
        ));
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
