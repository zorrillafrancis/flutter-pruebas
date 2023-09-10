import 'package:flutter/material.dart';
import 'package:mi_app_01/components/default_button.dart';
import 'package:mi_app_01/size_config.dart';
import '../../components/social_card.dart';

final List<String> errors = [];
String errorTextEmail = "Por favor agrege su correo";
String errorTextContrasena = "Por favor agrege su contraseña";

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
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String clave = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            FormError(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultButton(
                text: "Iniciar Sección",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
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

  TextFormField buildEmailFormField() {
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
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: "Correo",
          hintText: "Agrega tu Correo",
          suffixIcon: Icon(Icons.email)),
    );
  }

  TextFormField buildPasswordFormField() {
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
