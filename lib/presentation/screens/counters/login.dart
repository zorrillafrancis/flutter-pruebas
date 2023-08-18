import 'package:flutter/material.dart';
import 'package:mi_app_01/presentation/screens/bienvenida/bienvenida.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  Future<String?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString("userName") ?? '';

    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data != '') {
          return Bienvenida();
        } else {
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
                username(txtName),
                password(txtPass),
                ElevatedButton.icon(
                  label: const Text('Entrar'),
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    loginRedirect(txtName.text).then((value) {
                      if (value == true) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const Bienvenida();
                        }));
                      }
                    });
                    //Navigator.pushNamed(context, '/listview_2');
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      elevation: 15,
                      shadowColor: Colors.pink,
                      fixedSize: const Size(150, 40),
                      shape: const StadiumBorder()),
                )
              ],
            )),
          ));
        }
      },
    );
  }
}

Widget username(TextEditingController txtName) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    alignment: Alignment.center,
    child: TextField(
      controller: txtName,
      decoration: const InputDecoration(
          hintText: 'Username', fillColor: Colors.white, filled: true),
    ),
  );
}

Widget password(TextEditingController txtPass) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    alignment: Alignment.center,
    child: TextField(
      controller: txtPass,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'Password', fillColor: Colors.white, filled: true),
    ),
  );
}

Future<bool> loginRedirect(String user) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userName', user);
    return true;
  } catch (e) {
    return false;
  }
}
