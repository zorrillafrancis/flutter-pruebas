import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/vector-premium/paisaje-montana-bosque-arboles-noche_16058-115.jpg'),
                fit: BoxFit.cover),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              username(),
              password(),
              entreButton(context),
            ],
          ))),
    );
  }
}

Widget username() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    alignment: Alignment.center,
    child: const TextField(
      decoration: InputDecoration(
          hintText: 'Username', fillColor: Colors.white, filled: true),
    ),
  );
}

Widget password() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    alignment: Alignment.center,
    child: const TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password', fillColor: Colors.white, filled: true),
    ),
  );
}

Widget entreButton(BuildContext context) {
  return ElevatedButton.icon(
    label: const Text('Entrar'),
    icon: const Icon(Icons.login),
    onPressed: () {
      Navigator.pushNamed(context, '/listview_2');
    },
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 15,
        shadowColor: Colors.pink,
        fixedSize: const Size(150, 40),
        shape: const StadiumBorder()),
  );
}
