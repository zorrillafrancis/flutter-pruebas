import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_app_01/models/userModel.dart';
import 'package:mi_app_01/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/size_config.dart';

Future<List<UserModel>>? usersList;
List<UserModel> data = [];

class UsersBody extends StatefulWidget {
  const UsersBody({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersBody> createState() => _UsersState();
}

class _UsersState extends State<UsersBody> {
  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];

    String url = "${Environment.apiUrl}/users?pkidEmpresa=1";

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      try {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);

        for (dynamic item in jsonData['value']) {
          UserModel us = UserModel(
              item['nombre'],
              item['apellido'],
              item['usuario'],
              item['estatus'],
              item['celular'],
              item['email'],
              item['pkidempresa'],
              item['admin'],
              item['cuadreCaja']);

          data.add(us);
        }
      } catch (error) {
        print(error);
      }
    }

    return userList;
  }

  @override
  void initState() {
    super.initState();
    usersList = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: usersList,
                  builder: (BuildContext context, snapshot) {
                    print("==== connection =====");
                    print(snapshot.connectionState);
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(
                                    snapshot.data![index].usuario.toString()),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 120,
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data![index].nombre ?? ""} ${snapshot.data![index].apellido ?? ""}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              "${snapshot.data![index].usuario}\n${snapshot.data![index].email}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          margin: EdgeInsets.only(
                                              right:
                                                  getProportionateScreenWidth(
                                                      10),
                                              top: getProportionateScreenWidth(
                                                  10)),
                                          width: 30,
                                          child:
                                              snapshot.data![index].estatus ==
                                                      "1"
                                                  ? Icon(Icons.check_circle,
                                                      size: 30,
                                                      color: Colors.green[600])
                                                  : const Icon(
                                                      Icons
                                                          .disabled_by_default_rounded,
                                                      size: 30,
                                                      color: Colors.red,
                                                    )),
                                    ),
                                  ],
                                ),
                              );
                            });
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final UserModel user;
  const UserList({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 120,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.nombre ?? ""} ${user.apellido ?? ""}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "${user.usuario}\n${user.email}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: Container(
              padding: const EdgeInsets.only(right: 10),
              margin: EdgeInsets.only(
                  right: getProportionateScreenWidth(10),
                  top: getProportionateScreenWidth(10)),
              width: 30,
              child: user.estatus == "1"
                  ? Icon(Icons.check_circle, size: 30, color: Colors.green[600])
                  : const Icon(
                      Icons.disabled_by_default_rounded,
                      size: 30,
                      color: Colors.red,
                    )),
        ),
      ],
    );
  }
}
