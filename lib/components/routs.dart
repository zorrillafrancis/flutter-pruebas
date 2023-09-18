import 'package:flutter/widgets.dart';
import '../pages/bienvenida/bienvenida.dart';
import '../pages/facturas/facturasListado.dart';
import '../pages/sign_in/sign_in_screen.dart';
import '../pages/splash/splash_screen.dart';
import '../pages/product/product_details.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  Bienvenida.routeName: (context) => Bienvenida(),
  FacturasListado.routeName: (context) => FacturasListado(),
  DetailScreen.routeName: (context) => DetailScreen(),
};
