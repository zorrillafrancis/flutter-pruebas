import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mi_app_01/models/pokemon.dart';

import '../../../models/gif.dart';

void main() => runApp(const Restfull());

class Restfull extends StatefulWidget {
  const Restfull({super.key});

  @override
  State<Restfull> createState() => _RestfullState();
}

class _RestfullState extends State<Restfull> {
  Pokemon? pokemon;
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

  Future<void> getPokemon() async {
    String url = "https://pokeapi.co/api/v2/pokemon/1";

    final response = await http.get(Uri.parse(url));
    String body = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(body);

    pokemon = Pokemon.fromJson(jsonData);

    setState(() {});
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
            body: Center(
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
                          itemCount: snapshot.data?.length,
                          itemBuilder: (ctx, index) => ListTile(
                            leading: CircleAvatar(
                                backgroundColor: const Color(0xff764abc),
                                child: Text(
                                  snapshot.data![index].title
                                      .toString()
                                      .trim()
                                      .substring(0, 5),
                                  style: const TextStyle(color: Colors.white),
                                )),
                            title: Text(snapshot.data![index].title ?? 'nada'),
                            subtitle:
                                Text(snapshot.data![index].username ?? 'nada'),
                            contentPadding: const EdgeInsets.only(bottom: 1.0),
                            trailing: Image.network(snapshot
                                .data![index].images!.original.url
                                .toString()),
                          ),
                        );
                      }
                    })
                /*Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(listadoGifs?.data[0].username ?? 'no nada'),
                    if (listadoGifs?.data != null)
                      Image.network(listadoGifs?.data[0].images?.original.url ??
                          'no nada'),
                  ]),*/
                )));

    /*Center(child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
                onLongPress: () {},
                title: const Text('widget'),
                subtitle: const Text('subtitle'),
                visualDensity: VisualDensity.compact,
                leading: const CircleAvatar(child: Text('child')),
                trailing: const Icon(Icons.double_arrow));
          },
        )),
      ),*/
  }
}

getText(AsyncSnapshot<List<Datum>> snapshot, int index) {
  if (snapshot.data != null) {
    return snapshot.data![index].title.toString().trim().substring(0, 1);
  }
  return "hola";
}
