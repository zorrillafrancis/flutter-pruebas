import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/facturas/facturas_listado_body.dart';
import 'package:mi_app_01/pages/facturas/facturas_menu_header.dart';

class FacturasListado extends StatelessWidget {
  static String routeName = "/facturaListado";
  const FacturasListado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FacturasMenuHeader().getAppBar('Facturas'),
        body: SafeArea(child: FacturaListadoBody1()));
  }
}
