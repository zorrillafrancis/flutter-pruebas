import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_app_01/components/default_button.dart';
import 'package:mi_app_01/utils/constants.dart';
import 'package:mi_app_01/models/userModel.dart';
import 'package:mi_app_01/pages/bienvenida/bienvenida.dart';
import 'package:mi_app_01/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/social_card.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

final List<String> errors = [];
String errorTextEmail = "Por favor agrege su correo";
String errorTextContrasena = "Por favor agrege su contraseña";
bool loading = false;

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Text(
                  "Bienvenido",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Inicie con su correo y clave",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.07),
                SingForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingForm extends StatefulWidget {
  const SingForm({super.key});

  @override
  State<SingForm> createState() => _SingFormState();
}

class _SingFormState extends State<SingForm> {
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String clave = "";

  Future<bool> saveLogin(String user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('userName', user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModelResponse> login(String user, String pass) async {
    UserModelResponse umr = UserModelResponse("", null);

    try {
      String url = "${Environment.apiUrl}/users";
      var body = {"user": user, "password": pass};

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);

        if (jsonData['succeeded'] == true) {
          if (jsonData['value'] == null) {
            umr.mensaje = "La información de acceso no es corracta";
            return umr;
          }

          UserModel userModel = UserModel(
              jsonData['value']['nombre'],
              jsonData['value']['apellido'],
              jsonData['value']['usuario'],
              jsonData['value']['estatus'],
              jsonData['value']['celular'],
              jsonData['value']['email'],
              jsonData['value']['pkidempresa'],
              jsonData['value']['admin'],
              jsonData['value']['cuadreCaja']);

          umr.mensaje = "";
          umr.data = userModel;
        }
      }

      return umr;
    } catch (e) {
      print(e);
      umr.mensaje = e.toString();
      return umr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(txtUserName),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildPasswordFormField(txtPass),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            FormError(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            if (loading == true)
              const CircularProgressIndicator(color: kPrimaryColor),
            if (loading == false)
              DefaultButton(
                  text: "Iniciar Sección",
                  press: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      loading = true;
                    });

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (txtUserName.text == "" || txtPass.text == "") {
                        return;
                      }

                      login(txtUserName.text, txtPass.text).then((value) => {
                            {
                              setState(() {
                                loading = false;
                              }),
                              if (value.mensaje == "")
                                {
                                  saveLogin(
                                          '${value.data!.nombre} ${value.data!.apellido}')
                                      .then((value) {
                                    Navigator.pushNamed(
                                        context, Bienvenida.routeName);
                                  })
                                }
                              else
                                showDialog1(context, "Inicio", value.mensaje)
                            }
                          });
                    }
                  }),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recuerdame",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        decoration: TextDecoration.underline),
                  ),
                  Text(
                    "Olvide mi Contraseña",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialCard(icon: 'lib/assets/icons/google-icon.svg'),
                SocialCard(icon: 'lib/assets/icons/facebook-2.svg'),
                SocialCard(icon: 'lib/assets/icons/twitter.svg'),
              ],
            ),
          ],
        ));
  }

  TextFormField buildEmailFormField(TextEditingController txtUserName) {
    return TextFormField(
      onSaved: (newValue) => email = newValue.toString(),
      onChanged: (value) {
        setState(() {
          errors.remove(errorTextEmail);
        });
      },
      validator: (value) {
        if (value == null || value == '') {
          setState(() {
            errors.remove(errorTextEmail);
            errors.add(errorTextEmail);
          });
        }
        return null;
      },
      controller: txtUserName,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: "Correo",
          hintText: "Agrega tu Correo",
          suffixIcon: Icon(Icons.email)),
    );
  }

  TextFormField buildPasswordFormField(TextEditingController txtPass) {
    return TextFormField(
      onSaved: (newValue) => clave = newValue.toString(),
      onChanged: (value) {
        setState(() {
          errors.remove(errorTextContrasena);
        });
      },
      validator: (value) {
        if (value == null || value == '') {
          setState(() {
            errors.remove(errorTextContrasena);
            errors.add(errorTextContrasena);
          });
        }

        return null;
      },
      obscureText: true,
      controller: txtPass,
      decoration: const InputDecoration(
          labelText: "Contraseña",
          hintText: "Agrega tu Contraseña",
          suffixIcon: Icon(Icons.block)),
    );
  }
}

class FormError extends StatelessWidget {
  const FormError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(errors.length, (index) {
      return formErrorText(errors[index]);
    }));
  }

  Row formErrorText(String error) {
    return Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
          weight: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(5),
        ),
        Text(error)
      ],
    );
  }
}
