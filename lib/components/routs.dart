import 'package:flutter/widgets.dart';
import 'package:mi_app_01/pages/users/users.dart';
import '../pages/bienvenida/bienvenida.dart';
import '../pages/facturas/facturaDetalle.dart';
import '../pages/facturas/facturasListado.dart';
import '../pages/pruebas/prueba.dart';
import '../pages/sign_in/sign_in_screen.dart';
import '../pages/splash/splash_screen.dart';
import '../pages/product/product_details.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Users.routeName: (context) => Users(),
  SignInScreen.routeName: (context) => SignInScreen(),
  Bienvenida.routeName: (context) => Bienvenida(),
  FacturasListado.routeName: (context) => FacturasListado(),
  ProductDetails.routeName: (context) => ProductDetails(),
  FacturaDetalle.routeName: (context) => FacturaDetalle(),
  Prueba.routeName: (context) => Prueba(),
};
