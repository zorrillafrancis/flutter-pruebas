import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mi_app_01/models/Gif.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const Restfull());

class Restfull extends StatefulWidget {
  const Restfull({super.key});

  @override
  State<Restfull> createState() => _RestfullState();
}

class _RestfullState extends State<Restfull> {
  late Future<List<Gif>> listadoGifs;

  Future<List<Gif>> _getGifs() async {
    List<Gif> list = [];
    String url =
        "https://api.giphy.com/v1/gifs/trending?api_key=K7Ear4ZUaTO32x0OdsI181JV1iQqAmro&limit=25&offset=0&rating=g&bundle=messaging_non_clips";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);

        for (var item in jsonData['data']) {
          String name = item["username"];
          String type = item["type"];

          list.add(Gif(name, type));
        }
      } catch (e) {
        print(e);
      }
    }

    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listadoGifs = _getGifs();
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
            body: FutureBuilder(
                future: listadoGifs,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Gif>> snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (ctx, index) => const ListTile(                        
                        title: Text('aaa'),
                        subtitle: Text('bbb'),
                        contentPadding: EdgeInsets.only(bottom: 20.0),
                      ),
                    );
                  }
                })

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
            ));
  }
}
