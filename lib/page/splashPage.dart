import 'dart:async';

import 'package:firebase_1_setting/page/homePage.dart';
import 'package:firebase_1_setting/page/sigInPage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String id = "splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _intiTimer();
  }
  void _intiTimer(){
    Timer(const Duration(seconds: 3),(){
      _callNextPage();
    });
  }
  _callNextPage(){
    Navigator.pushReplacementNamed(context, SigInPage.id);
      // if(isLoggenIn){
      //
      // }else{
      //   Navigator.pushReplacementNamed(context, SigInPage.id);
      // }
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
                Color.fromRGBO(131, 58, 180, 1)
              ]
            
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Center(
              child: const Text("Welcome" ,style: TextStyle(color: Colors.white, fontSize: 35),),
             ),
            ),
            const Text("All rights reserved", style: TextStyle(color: Colors.white, fontSize: 16),),
           const  SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
