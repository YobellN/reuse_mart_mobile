import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reuse_mart_mobile/view/notification-screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

// PAGES
import 'package:reuse_mart_mobile/pages/hunterHomePages.dart';
import 'package:reuse_mart_mobile/pages/kurirHomePages.dart';
import 'package:reuse_mart_mobile/pages/loginPages.dart';
import 'package:reuse_mart_mobile/pages/pembeliHomePages.dart';
import 'package:reuse_mart_mobile/pages/penitipHomePages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initializeLocalNotifications();
  await _requestPermission();
  _setupFCMListeners();

  // Ambil shared preferences
  final prefs = await SharedPreferences.getInstance();
  final tokenUser = prefs.getString('token');
  final role = prefs.getString('role');

  // Tentukan initial route
  String initialRoute;
  if (tokenUser != null) {
    switch (role) {
      case 'Penitip':
        initialRoute = '/penitipHome';
        break;
      case 'Pembeli':
        initialRoute = '/pembeliHome';
        break;
      case 'Kurir':
        initialRoute = '/kurirHome';
        break;
      case 'Hunter':
        initialRoute = '/hunterHome';
        break;
      default:
        initialRoute = '/login';
    }
  } else {
    initialRoute = '/login';
  }

  runApp(MyApp(initialRoute: initialRoute));

  _checkInitialMessage();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');
}


Future<void> _initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_reusemart');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder:
              (context) => NotificationScreen(message: response.payload ?? ""),
        ),
      );
    },
  );
}

Future<void> _requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('Authorization status: ${settings.authorizationStatus}');
}

void _setupFCMListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      _showForegroundNotification(
        message.notification!.title,
        message.notification!.body,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _handleMessage(message);
  });
}

Future<void> _showForegroundNotification(String? title, String? body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'reusemart_channel',
    'ReuseMart Notifications',
    channelDescription: 'Channel for ReuseMart push notifications',
    importance: Importance.max,
    priority: Priority.high,
    icon: 'ic_stat_reusemart',
    color: Color(0xFF4CAF50),
    colorized: true,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title ?? 'Notifikasi',
    body ?? '',
    notificationDetails,
    payload: body ?? '',
  );
}

void _handleMessage(RemoteMessage message) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder:
          (context) =>
              NotificationScreen(message: message.notification?.body ?? ''),
    ),
  );
}

void _checkInitialMessage() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: { // Pembeli, Penitip, Kurir, Hunter
        '/login': (_) => LoginPage(),
        '/penitipHome': (_) => PenitipHomePage(),
        '/pembeliHome': (_) => PembeliHomePage(),
        '/kurirHome': (_) => KurirHomePage(),
        '/hunterHome': (_) => HunterHomePage(),
      },
      navigatorKey: navigatorKey,
      title: 'ReuseMart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}