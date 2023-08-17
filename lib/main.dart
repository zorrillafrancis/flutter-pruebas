import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/facturas/facturasListado.dart';
import 'package:mi_app_01/pages/mensaje_page.dart';
import 'package:mi_app_01/presentation/screens/bienvenida/bienvenida.dart';
import 'package:mi_app_01/presentation/screens/counters/login.dart';
import 'package:mi_app_01/presentation/screens/listview/listview_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

//AAAA3o67N9M:APA91bFJwoYv1zkyFXOCzdmDjbjuiBn4h8319RC8dgjq02W7syzb1YZC5wet2-tkkgwoWH_enTC9onXms0cP4KD6Niy9s5Qbu80LJ0s1ZNwVukpLpuCdgrAESWhDFF_CJm1v98aO39e7
final GlobalKey<NavigatorState> natigatorKey = GlobalKey<NavigatorState>();
String? userNameVa = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'flutter1',
    options: const FirebaseOptions(
      apiKey:
          "AAAA3o67N9M:APA91bFJwoYv1zkyFXOCzdmDjbjuiBn4h8319RC8dgjq02W7syzb1YZC5wet2-tkkgwoWH_enTC9onXms0cP4KD6Niy9s5Qbu80LJ0s1ZNwVukpLpuCdgrAESWhDFF_CJm1v98aO39e7",
      appId: "334819000485",
      messagingSenderId: "334890062485",
      projectId: "schoolsolutions-push",
    ),
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();

  userNameVa = prefs.getString("userName") ?? '';

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

/*
    print('test 1');

    final pushProvider = PushNotificationProvider();
    print('test 2');
    pushProvider.initNotifications();

    pushProvider.mensajes.listen((event) {
      print('argumento x');

      //  natigatorKey.currentState?.pushNamed('mensaje', arguments: event);
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: natigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': ((context) {
          return InitPage();
        }),
        'mensaje': ((context) => const MensajePage()),
        'facturaListado': ((context) => const FacturasListado()),
        'facturaDetalle': ((context) => const Details(
              numeroFactura: "",
            )),
      },
    );
  }
}

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: loadData(),
      builder: (context, snapshot) {
        // while loading data
        print(snapshot.data);
        if (snapshot.data == null) {
          print('loading...');
          return CircularProgressIndicator();
        }
        // if has error
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // retrieve data - check for authentication

        // authenticated, go to homescreen
        print('validar data');
        print(snapshot.data);
        if (snapshot.data != '') {
          print('In HomeScreen');
          return Bienvenida(
              usuario: snapshot.data.toString(), password: 'francis');
        }
        // not authenticated, go to auth screen
        print('In Authenicate or Login');
        return Login();
      },
    );
  }
}

Future<String?> loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("userName");
}

/*
class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: loadData(),
      builder: (context, snapshot) {
        // while loading data
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        }
        // if has error
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // retrieve data - check for authentication

        // authenticated, go to homescreen
        if (snapshot.data == true) {
          print('In HomeScreen');
          return HomePage();
        }
        // not authenticated, go to auth screen
        print('In Authenicate or Login');
        return MensajePage();
      },
    );
  
  }
}
*/
/*
if (emailController.text == "arun@gogosoon.com" && passwordController.text == "qazxswedcvfr") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(
        email: emailController.text,
    )),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Invalid Credentials')),
    );
}
*/

/* 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Titulo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Details(
          numeroFactura: '',
        ));
  }
} */
