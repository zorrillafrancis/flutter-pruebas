import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListPerson extends StatefulWidget {
  const ListPerson({super.key});

  @override
  State<ListPerson> createState() => _ListPersonState();
}

class _ListPersonState extends State<ListPerson> {
  List<Personas> _personas = [
    Personas(1, 'Francis', 'Zorrilla', '809-901-4419'),
    Personas(2, 'Juan', 'Garcia', '829-458-8569'),
    Personas(3, 'Mariela', 'Borjas', '809-901-4419'),
    Personas(4, 'Jennifer', 'Ramos', '809-901-4419'),
  ];

  borrar(context, personas) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Eliminar contacto"),
            content: const Text('Esta seguro'),
            actions: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                ),
                child: const Text('Borrar'),
                onPressed: () {
                  setState(() {
                    _personas = _personas
                        .where((element) => element.name != personas)
                        .toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                ),
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: _personas.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onLongPress: () {
                    borrar(context, _personas[index].name);
                  },
                  title: Text(_personas[index].name),
                  subtitle: Text(_personas[index].phone),
                  visualDensity: VisualDensity.compact,
                  leading: CircleAvatar(
                      child: Text(_personas[index].name.substring(0, 1))),
                  trailing: const Icon(Icons.double_arrow));
            }));
  }
}

class Personas {
  int id = 0;
  String name = "";
  String lastName = "";
  String phone = "";

  Personas(this.id, this.name, this.lastName, this.phone);
}
