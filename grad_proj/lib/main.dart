import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:calendar_view/calendar_view.dart';
import 'admin/controllers/menu_controller.dart' as MyMenuController;
import 'landing/navebar/homepage.dart';
import 'landing/splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login/provider/UserProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBKlOlsVnE0lb5HSuYyusVCkNyLRLOtgVw",
          authDomain: "gradproj-a818c.firebaseapp.com",
          projectId: "gradproj-a818c",
          storageBucket: "gradproj-a818c.appspot.com",
          messagingSenderId: "988806572251",
          appId: "1:988806572251:web:e179b7f837efd2f7c8c4fe",
          measurementId: "G-D1CL97P6E5"),
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    String? fcmToken = await messaging.getToken(
        vapidKey:
            'BLiekrxh3FPfzML-K23lSb-bKVinHkEMwzOrw8G402mdiWRnxQ6YEzTDutMGzcdDaDxukq_K-dJOCxvby0I_BYQ');
    print("FCM Token: $fcmToken");
  } else {
    // await Firebase.initializeApp();
    /* await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );*/
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    String? fcmToken = await messaging.getToken();
    print("FCM Token: $fcmToken");
  }
  /*;*/
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MyMenuController.MenuController>(
            create: (context) => MyMenuController.MenuController()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("don notefecation ");
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });*/
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // Add your notification handling logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: const MaterialApp(
        title: 'My App',
        home: kIsWeb ? WebHomePage() : MobileHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
      },
    );
  }
}

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' WheelsWell',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Barlow',
          textTheme: TextTheme(
              displayLarge: const TextStyle(
                fontSize: 70,
                color: Colors.black,
                fontFamily: 'DMSerifDisplay',
              ),
              displayMedium: const TextStyle(
                  fontSize: 55,
                  color: Colors.black,
                  fontFamily: 'DMSerifDisplay'),
              displaySmall: const TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontFamily: 'DMSerifDisplay'),
              titleMedium: TextStyle(fontSize: 30, color: Colors.grey[500]),
              titleSmall: TextStyle(fontSize: 20, color: Colors.grey[500]),
              bodyLarge: const TextStyle(
                  fontSize: 20, color: Colors.black, height: 1.25),
              bodyMedium: const TextStyle(
                  fontSize: 17, color: Colors.black, height: 1.25),
              bodySmall: const TextStyle(
                  fontSize: 15, color: Colors.black, height: 1.25),
              labelLarge:
                  const TextStyle(fontSize: 17, color: Color(0xff1e1e24)))),
      home: const HomePage(),
    );
  }
}
