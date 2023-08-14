import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/pages/home_page.dart';
import 'package:mi_app_01/pages/mensaje_page.dart';
import 'package:mi_app_01/src/provider/push_notifications_provider.dart';

//AAAA3o67N9M:APA91bFJwoYv1zkyFXOCzdmDjbjuiBn4h8319RC8dgjq02W7syzb1YZC5wet2-tkkgwoWH_enTC9onXms0cP4KD6Niy9s5Qbu80LJ0s1ZNwVukpLpuCdgrAESWhDFF_CJm1v98aO39e7
final GlobalKey<NavigatorState> natigatorKey = GlobalKey<NavigatorState>();

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

    print('test 1');

    final pushProvider = PushNotificationProvider();
    print('test 2');
    pushProvider.initNotifications();

    pushProvider.mensajes.listen((event) {
      print('argumento x');

      //  natigatorKey.currentState?.pushNamed('mensaje', arguments: event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: natigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': ((context) => const HomePage()),
        'mensaje': ((context) => const MensajePage())
      },
    );
  }
}

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
