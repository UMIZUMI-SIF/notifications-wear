import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_wear/main.dart';

class FirebaseApi {
  // Instance
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications
  Future<void> initNotifications() async {
    // Request permission
    await _firebaseMessaging.requestPermission();

    // token fot this device
    final token = await _firebaseMessaging.getToken();

    print('Token: $token');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
