import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/foundation.dart';
import '../../data/data-entity.dart';
import '../../main.dart';
import '../../pages/factura_detalle/factura_detalle.dart';

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
      try {
        if (kDebugMode) {
          print('=====xxxx Aplicacion Abierta xxx===== 1111');
          print(message.data['id']);
        }

        int argumento = int.parse(message.data['id']);

        if (kDebugMode) {
          print('==== argumento====');
          print(argumento);
        }

        natigatorKey.currentState?.pushNamed('/facturaDetalle',
            arguments: FacturaDetalleArguments(facturaId: argumento));
      } catch (e) {
        print(e);
      }
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      try {
        if (kDebugMode) {
          print('===== onMessage Aplicacion Abierta =====222');
          print(message.data['id']);
        }

        int argumento = int.parse(message.data['id']);

        if (Platform.isAndroid) {
          if (message.notification != null) {
            if (kDebugMode) {
              print('==== argumento====');
              print(argumento);
            }

            _mensajesStreamcontroller.sink.add(argumento.toString());
            natigatorKey.currentState?.pushNamed('/facturaDetalle',
                arguments: FacturaDetalleArguments(facturaId: argumento));
          }
        }
      } catch (e) {
        print(e);
      }
    });
  }

  dispose() {
    _mensajesStreamcontroller.close();
  }
}
