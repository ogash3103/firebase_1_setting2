import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String id = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: Center(
      //   child: MaterialButton(
      //     onPressed: (){
      //       AuthService.signOutUser(context);
      //     },
      //     child:  Text("Log Out"),
      //     color: Colors.blue,
      //
      //   ),
      // )
    );
  }
}
