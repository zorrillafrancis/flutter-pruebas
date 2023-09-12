import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_app_01/components/routs.dart';
import 'package:mi_app_01/src/provider/chatProvider.dart';
import 'package:mi_app_01/pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/theme.dart';

//AAAA3o67N9M:APA91bFJwoYv1zkyFXOCzdmDjbjuiBn4h8319RC8dgjq02W7syzb1YZC5wet2-tkkgwoWH_enTC9onXms0cP4KD6Niy9s5Qbu80LJ0s1ZNwVukpLpuCdgrAESWhDFF_CJm1v98aO39e7
final GlobalKey<NavigatorState> natigatorKey = GlobalKey<NavigatorState>();
String? userNameVa = "";
bool loggedIn = false;

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

  if (prefs.getString('userName') != null &&
      prefs.getString('userName') != '') {
    loggedIn = true;
  }

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                TotalsProvider(total: 0, subtotal: 0, itbis: 0, descuento: 0))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: natigatorKey,
        title: 'Material App',
        theme: getTheme(context),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
