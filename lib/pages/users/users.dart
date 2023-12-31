import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/users/users_body.dart';
import '../../utils/size_config.dart';
import '../facturas/facturas_menu_header.dart';

class Users extends StatelessWidget {
  static String routeName = '/users';
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: FacturasMenuHeader().getAppBar('Usuarios'),
      body: UsersBody(),
    );
  }
}
