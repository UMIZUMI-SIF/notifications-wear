import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationIconWidget extends StatefulWidget {
  // Recibir argumento bool para saber si se recibió una notificación
  final bool initialNotificationState; // Paso 1: Definir el parámetro

  NotificationIconWidget({Key? key, this.initialNotificationState = false})
      : super(key: key); // Hacer el parámetro opcional con un valor por defecto

  @override
  _NotificationIconWidgetState createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  bool _notificationReceived = false;

  bool get notificationReceived => _notificationReceived;

  @override
  void initState() {
    super.initState();
    initPushNotifications();
  }

  Future<void> initPushNotifications() async {
    // Suscribirse al tópico de notificaciones
    await FirebaseMessaging.instance.subscribeToTopic('led');

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        setState(() {
          handleNotification(message);
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      setState(() {
        handleNotification(message);
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      setState(() {
        handleNotification(message);
      });
    });
  }

  // Parsear la notificación
  void handleNotification(RemoteMessage message) {
    String? notificationBody = message.notification?.body;

    setState(() {
      _notificationReceived =
          notificationBody?.toUpperCase().contains("Encendido") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _notificationReceived
            ? Icons.radio_button_off
            : Icons.radio_button_checked_outlined,
        color: _notificationReceived ? Colors.blueAccent : Colors.white,
        size: 50,
      ),
      onPressed: () {
        // Aquí puedes definir lo que sucede cuando se toca el icono
      },
    );
  }
}
