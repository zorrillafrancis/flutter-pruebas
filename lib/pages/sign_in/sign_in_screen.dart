import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/sign_in/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Body());
  }
}
