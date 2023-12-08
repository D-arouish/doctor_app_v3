import 'package:doctor_app_v3/screens/appointment_page.dart';
import 'package:doctor_app_v3/screens/auth_page.dart';
import 'package:doctor_app_v3/screens/booking_page.dart';
import 'package:doctor_app_v3/screens/change_password_page.dart';
import 'package:doctor_app_v3/screens/qr_code_scanner.dart';
import 'package:doctor_app_v3/services/notification_page.dart';
import 'package:doctor_app_v3/screens/profile_page.dart';
import 'package:doctor_app_v3/screens/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'firebase_options.dart';
import 'main_layout.dart';
import 'utils/config.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Widget startScreen = const AuthPage();
    if (user != null) {
      startScreen = const MainLayout();
    }

    //define ThemeData here
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //pre-define input decoration
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => startScreen,
        'main': (context) => const MainLayout(),
        'appointment_page': (context) => const AppointmentPage(),
        'booking_page': (context) => const BookingPage(),
        'notification_page': (context) => const NotificationPage(),
        'auth_page' : (context) => AuthPage(),
        'settings_page' : (context) => SettingsPage(),
        'profile_page' : (context) => ProfilePage(),
        'change_password_page' : (context) => ChangePasswordPage(),
        'qr_scanner_page' : (context) => ScannerPage(),
        //'success_booking': (context) => const AppointmentBooked(),
      },
    );
  }
}
