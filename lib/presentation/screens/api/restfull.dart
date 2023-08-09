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
  Gif? listadoGifs;
  String url = "";

  Future<void> getGifs() async {
    String url =
        "https://api.giphy.com/v1/gifs/trending?api_key=K7Ear4ZUaTO32x0OdsI181JV1iQqAmro&limit=25&offset=0&rating=g&bundle=messaging_non_clips";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);
        listadoGifs = Gif.fromJson(jsonData);

        /*    for (var item in jsonData['data']) {
          print(item);
        } */

        print(listadoGifs);
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
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
    getGifs();
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(listadoGifs?.data[0].username ?? 'no nada'),
                    if (listadoGifs?.data != null)
                      Image.network(listadoGifs?.data[0].images?.original.url ??
                          'no nada'),
                    /* ListView.builder(
                      shrinkWrap: true,
                      itemCount: listadoGifs?.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(listadoGifs?.data[index].title ?? ''),
                          visualDensity: const VisualDensity(vertical: 1),
                          leading:
                              Text(listadoGifs?.data[index].username ?? ''),
                        );
                      },
                    ) */
                  ]),
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
