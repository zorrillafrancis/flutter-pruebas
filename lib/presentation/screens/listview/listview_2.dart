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

  void showDialog1(String value) {
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
        title: const Text("AppMaking.com"),
        centerTitle: true,
        backgroundColor: const Color(0xff764abc),
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
                  showDialog1(text.toUpperCase());
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
                            onSelected: (String value) {},
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
}
