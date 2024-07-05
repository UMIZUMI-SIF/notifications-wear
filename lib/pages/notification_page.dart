import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications_wear/widgets/notification_icon_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get notification message and show
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    String? notificationBody = message.notification?.body;

    return Scaffold(
      backgroundColor: Colors.blue, // Fondo azul
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NotificationIconWidget(
            initialNotificationState:
                notificationBody!.toUpperCase().contains("ENCENDIDO"),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Encendido",
              style: TextStyle(
                color: Colors.white, // Letras blancas
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
