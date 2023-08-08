import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_detail.dart';

class Listview2 extends StatefulWidget {
  const Listview2({super.key});

  @override
  State<Listview2> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Listview2>
    with SingleTickerProviderStateMixin {
  var selectedItem = '';
  int _selectedIndex = 0;
  List<Map<String, dynamic>> allUsers = [
    {"id": 1, "name": "Francis", "age": 30},
    {"id": 2, "name": "Ana", "age": 20},
    {"id": 3, "name": "Maria", "age": 10},
    {"id": 4, "name": "Rosa", "age": 10},
    {"id": 5, "name": "Pedro", "age": 15},
    {"id": 6, "name": "Elena", "age": 10},
    {"id": 7, "name": "Angelica", "age": 32},
    {"id": 8, "name": "Ruben", "age": 10},
    {"id": 9, "name": "Carlos", "age": 30},
    {"id": 10, "name": "Diego", "age": 20},
    {"id": 11, "name": "Tomas", "age": 10},
    {"id": 12, "name": "Lorenzo", "age": 10},
    {"id": 13, "name": "Agustin", "age": 10},
    {"id": 14, "name": "Ricardo", "age": 32},
    {"id": 15, "name": "Francisco", "age": 10},
    {"id": 16, "name": "Irma", "age": 10},
    {"id": 17, "name": "Dario", "age": 32},
    {"id": 18, "name": "Miguel", "age": 32},
  ];

  List<Map<String, dynamic>> foundUser = [];

  @override
  void initState() {
    foundUser = allUsers;
    super.initState();
  }

  void search(String value) {
    List<Map<String, dynamic>> result = [];

    if (value.isEmpty) {
      result = allUsers;
    } else {
      result = allUsers
          .where(
              (user) => user["name"].toString().toUpperCase().contains(value))
          .toList();
    }

    setState(() {
      foundUser = result;
    });
  }

  void addNew() {
    Map<String, dynamic> add = {"id": 1, "name": "Francis", "age": 30};

    allUsers.add(add);

    setState(() {
      foundUser = allUsers;
    });
  }

  void delete(Map<String, dynamic> id) {
    allUsers.remove(id);

    setState(() {
      foundUser = allUsers;
    });
  }

  void edit(Map<String, dynamic> data) {
    //  List<Map<String, dynamic>> result = [];
    foundUser = allUsers.where((user) => user["id"] == data["id"]).toList();

    setState(() {});
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('School Solutions'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          PopupMenuButton(onSelected: (value) {
            // your logic
            setState(() {
              selectedItem = value.toString();
            });
            // Navigator.pushNamed(context, value.toString());
          }, itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                value: '/hello',
                child: Text("Hello"),
              ),
              PopupMenuItem(
                value: '/about',
                child: Text("About"),
              ),
              PopupMenuItem(
                value: '/contact',
                child: Text("Contact"),
              )
            ];
          })
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        addNew();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Nuevo'),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                      )),
                  const SizedBox(width: 5),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      label: const Text('Borrar'),
                      style: ElevatedButton.styleFrom(elevation: 10)),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: foundUser.length,
                    itemBuilder: (context, index) {
                      return Card(
                        key: ValueKey(foundUser[index]['id'].toString()),
                        color: Colors.white,
                        elevation: 0.4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Details(),
                                ));
                          },
                          visualDensity: const VisualDensity(vertical: 1),
                          leading: CircleAvatar(
                              backgroundColor: const Color(0xff764abc),
                              child: Text(
                                foundUser[index]['id'].toString(),
                                style: const TextStyle(color: Colors.white),
                              )),
                          title: Text(
                            foundUser[index]['name'].toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                              '${foundUser[index]['age'].toString()} años de edad',
                              style: const TextStyle(color: Colors.black45)),
                          trailing: PopupMenuButton(
                            shadowColor: const Color.fromARGB(255, 61, 59, 60),
                            elevation: 5,
                            tooltip: "",
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Editar'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Borrar'),
                                )
                              ];
                            },
                            onSelected: (String value) {
                              if (value == 'delete' && 1 == 1) {
                                showAlert(context, foundUser[index]);
                              } else {
                                var data = foundUser[index];
                                setState(() {
                                  showFullModal(context, data);
                                });
                              }
                            },
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue[500],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.blue[500],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.blue[500],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.blue[500],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: onItemTapped,
      ),
    );
  }

  showAlert(BuildContext context, Map<String, dynamic> id) {
    // set up the button
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Si"),
      onPressed: () {
        delete(id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Borrar"),
      content: const Text("Desea borrar el registro?"),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

showFullModal(context, data) {
  String name = data["name"];
  int age = data["age"];

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEdad = TextEditingController();

  txtName.text = name;
  txtEdad.text = age.toString();

  showGeneralDialog(
    context: context,
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    barrierLabel: "Modal", // label for barrier
    transitionDuration: const Duration(
        milliseconds:
            200), // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text(
              "Titulo de Pantalla",
              style: TextStyle(
                  color: Colors.black87, fontFamily: 'Overpass', fontSize: 20),
            ),
            elevation: 0.0),
        backgroundColor: Colors.white.withOpacity(0.90),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xfff8f8f8),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: txtName,
                  decoration: const InputDecoration(
                      alignLabelWithHint: false,
                      label: Text('Nombre'),
                      hintText: "texto oculto",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: txtEdad,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text('Edad'),
                      border: OutlineInputBorder()),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ButtonTheme(
                  minWidth: 200.0,
                  height: 150.0,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        elevation: 15,
                        shadowColor: Colors.pink,
                        fixedSize: const Size(170, 35),
                        shape: const StadiumBorder()),
                    label: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton.icon(
                  onHover: (value) {
                    if (kDebugMode) {
                      print('object');
                    }
                  },
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    // var object = _MyWidgetState();
                    /*var result = object.allUsers
                        .where((user) => user["id"] == data["id"])
                        .toList();*/

                    Navigator.of(context).pop();

                    //object.edit(data);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 15,
                      shadowColor: Colors.green,
                      fixedSize: const Size(170, 35),
                      shape: const StadiumBorder()),
                  label: const Text('Guardar'),
                ),
              ]),
            ],
          ),
        ),
      );
    },
  );
}

sendedit() {}
