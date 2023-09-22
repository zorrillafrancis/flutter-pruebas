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
              nombre: item['nombre'],
              apellido: item['apellido'],
              usuario: item['usuario'],
              estatus: item['estatus'],
              celular: item['celular'],
              email: item['email'],
              pkidempresa: item['pkidempresa'],
              admin: item['admin'],
              cuadreCaja: item['cuadreCaja']);

          userList.add(us);
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
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
              future: usersList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => LoadingList(),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 16,
                                ),
                            itemCount: 8));
                  case ConnectionState.done:
                    final posts = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return UserList(
                            user: posts[index],
                          );
                        });
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              }),
        ),
      ],
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

class LoadingList extends StatelessWidget {
  const LoadingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Loading(
            height: 120,
            width: 120,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Loading(width: 80),
              SizedBox(height: 8),
              Loading(),
              SizedBox(height: 8),
              Loading(),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Loading()),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final double? height, width;

  const Loading({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
