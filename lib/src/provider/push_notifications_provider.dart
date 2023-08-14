import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';

FirebaseInstallations installations = FirebaseInstallations.instance;

class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _mensajesStreamcontroller = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamcontroller.stream;

  initNotifications() {
    _firebaseMessaging.getToken().then((token) {
      print('====== token ======');
      print(token);
    });

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    _firebaseMessaging.getInitialMessage().then((info) {
      print('===== on getInitialMessage =====');
      print(info);
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('=====xxxx onResume xxx=====');
      print('===== onResume =====');
      //natigatorKey.currentState?.pushNamed('mensaje', arguments: message);
      String argumento = message.data['id'] ?? 'no-data';

      natigatorKey.currentState?.pushNamed('mensaje', arguments: argumento);
      print(message);
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('===== onMessage =====222');

      String argumento = "no-data";
      print('argumento 22222222');
      print(message);

      if (Platform.isAndroid) {
        argumento = message.data['id'] ?? 'no-data';

        if (message != null) {
          print("onMessage data: ${message.sentTime}");
        }
        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification!.title} body ${message.notification!.body}');
          print("este es el di " + message.data["id"]);

          _mensajesStreamcontroller.sink.add(argumento);
        }
      }
    });
  }

  dispose() {
    _mensajesStreamcontroller.close();
  }
}


/*

https://fcm.googleapis.com/fcm/send
token
AAAA3o67N9M:APA91bFJwoYv1zkyFXOCzdmDjbjuiBn4h8319RC8dgjq02W7syzb1YZC5wet2-tkkgwoWH_enTC9onXms0cP4KD6Niy9s5Qbu80LJ0s1ZNwVukpLpuCdgrAESWhDFF_CJm1v98aO39e7

{
"to":"f3Fknm60R4que-RwtuZt_a:APA91bEBfdvGhCpT8LCANIbmubRBEgU3uuL7uRptD_3n7IBVyWBLhmkR8WrqBX1OKvHOzrwnuF41_KFz8MPuO58QN08CYxaA-ncZBOWy7KIk5FhX1fwcvft7b8KA116EXXtRlWj1L5wt",
"notification":
{
"title": "postman",
"body": "body desde postman"
},
"data": {
"comida": "mi comida"
}
}
*/