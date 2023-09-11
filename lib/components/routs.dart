import 'package:flutter/widgets.dart';
import 'package:mi_app_01/pages/bienvenida/bienvenida.dart';
import 'package:mi_app_01/pages/facturas/facturasListado.dart';
import 'package:mi_app_01/pages/sign_in/sign_in_screen.dart';
import 'package:mi_app_01/pages/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  Bienvenida.routeName: (context) => Bienvenida(),
  FacturasListado.routeName: (context) => FacturasListado(),
};
