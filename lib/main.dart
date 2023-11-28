import 'package:firebase_1_setting/page/SigUpPage.dart';
import 'package:firebase_1_setting/page/homePage.dart';
import 'package:firebase_1_setting/page/sigInPage.dart';
import 'package:firebase_1_setting/page/splashPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        HomePage.id: (context) => const  HomePage(),
        SplashPage.id : (context) => const SplashPage(),
        SigInPage.id : (context) => const SigInPage(),
        SigUpPage.id : (context) => const SigUpPage(),
      },
    );
  }
}

