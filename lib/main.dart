import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reuse_mart_mobile/view/notification-screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _requestPermission();

  runApp(const MyApp());

  _setupFCMListeners();
  _checkInitialMessage();

  final token = await FirebaseMessaging.instance.getToken();
  print('Token: $token');
}

Future<void> _requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User mengizinkan notifikasi');
  } else {
    print('User tidak mengizinkan notifikasi');
  }
}

void _setupFCMListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      _showForegroundDialog(
        message.notification!.title,
        message.notification!.body,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _handleMessage(message);
  });
}

_showForegroundDialog(String? title, String? body) {
  showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(title: Text(title ?? ""), content: Text(body ?? ""));
    },
  );
}

void _handleMessage(RemoteMessage message) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (context) =>
          NotificationScreen(message: message.notification?.body ?? ""),
    ),
  );
}

void _checkInitialMessage() async {
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
          ],
        ),
      ),
    );
  }
}
