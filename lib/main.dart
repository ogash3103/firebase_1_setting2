import 'package:firebase_1_setting/page/SigUpPage.dart';
import 'package:firebase_1_setting/page/homePage.dart';
import 'package:firebase_1_setting/page/sigInPage.dart';
import 'package:firebase_1_setting/page/splashPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: const SplashPage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        SplashPage.id: (context) => const SplashPage(),
        SigInPage.id: (context) => const SigInPage(),
        SigUpPage.id: (context) => const SigUpPage(),
      },
    );
  }
}
