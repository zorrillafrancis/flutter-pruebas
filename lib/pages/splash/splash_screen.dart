import 'package:flutter/material.dart';
import 'package:mi_app_01/components/body.dart';
import 'package:mi_app_01/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
