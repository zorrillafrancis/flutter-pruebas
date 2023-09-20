import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/foundation.dart';
import '../../data/data-entity.dart';
import '../../main.dart';

FirebaseInstallations installations = FirebaseInstallations.instance;

class PushNotificationProvider {
  DataEntity de = DataEntity();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _mensajesStreamcontroller = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamcontroller.stream;

  initNotifications() {
    _firebaseMessaging.getToken().then((token) {
      if (kDebugMode) {
        print('====== token ======');
        print(token);
      }
      de.saveToken(token!, 4);
    });

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    _firebaseMessaging.getInitialMessage().then((info) {
      if (kDebugMode) {
        print('===== on Aplicacion Completamente Cerrada =====');
        print(info);
      }
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('=====xxxx Aplicacion Abierta xxx=====');
      }

      String argumento = message.data['id'] ?? 'no-data';

      if (kDebugMode) {
        print('==== argumento====');
        print(argumento);
      }

      natigatorKey.currentState
          ?.pushNamed('/facturaDetalle', arguments: argumento);
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('===== onMessage Aplicacion Abierta =====222');
      }

      String argumento = "no-data";

      if (Platform.isAndroid) {
        argumento = message.data['id'] ?? 'no-data';

        if (message.notification != null) {
          if (kDebugMode) {
            print('==== argumento====');
            print(argumento);
          }

          _mensajesStreamcontroller.sink.add(argumento);
          natigatorKey.currentState
              ?.pushNamed('/facturaDetalle', arguments: argumento);
        }
      }
    });
  }

  dispose() {
    _mensajesStreamcontroller.close();
  }
}
