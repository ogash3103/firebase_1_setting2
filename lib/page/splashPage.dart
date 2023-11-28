import 'dart:async';

import 'package:firebase_1_setting/page/SigUpPage.dart';
import 'package:firebase_1_setting/page/homePage.dart';
import 'package:firebase_1_setting/page/mainPage.dart';
import 'package:firebase_1_setting/page/sigInPage.dart';
import 'package:firebase_1_setting/service/auth_service.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key});
  static const String id = "splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    Timer(const Duration(seconds: 3), _callNextPage);
  }

  _callNextPage() {
    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Navigator.pushReplacementNamed(context, SigInPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: const Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 35),),
              ),
            ),
            const Text("All rights reserved", style: TextStyle(color: Colors.white, fontSize: 16),),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
