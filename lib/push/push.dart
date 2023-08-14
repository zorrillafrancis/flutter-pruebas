import 'package:flutter/material.dart';

import '../src/provider/push_notifications_provider.dart';
import 'package:firebase_core/firebase_core.dart';

class Push extends StatefulWidget {
  const Push({super.key});

  @override
  State<Push> createState() => _PushState();
}

class _PushState extends State<Push> {
  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:
            "AAAA3o67N9M:APA91bFJwoYv1zkyFXOCzdmDjbjuiBn4h8319RC8dgjq02W7syzb1YZC5wet2-tkkgwoWH_enTC9onXms0cP4KD6Niy9s5Qbu80LJ0s1ZNwVukpLpuCdgrAESWhDFF_CJm1v98aO39e7",
        appId: "334819000485",
        messagingSenderId: "334890062485",
        projectId: "schoolsolutions-push",
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // init();

    final PushNotificationProvider pushProvider = PushNotificationProvider();

    pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World...!',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
      ),
    );
  }
}
