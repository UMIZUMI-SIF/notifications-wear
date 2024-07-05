import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:push_notifications_wear/api/firebase_api.dart';
import 'package:push_notifications_wear/firebase_options.dart';
import 'package:push_notifications_wear/pages/home_page.dart';
import 'package:push_notifications_wear/pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notificaciones",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.compact,
      ),
      home: const WatchScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationPage(),
      },
    );
  }
}

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WatchShape(builder: (context, shape, child) {
      return AmbientMode(
        builder: (context, mode, child) => Counter(mode),
      );
    });
  }
}

class Counter extends StatefulWidget {
  final WearMode mode;
  const Counter(this.mode, {super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
