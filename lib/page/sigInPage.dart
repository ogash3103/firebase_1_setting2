import 'package:flutter/material.dart';

class SigInPage extends StatefulWidget {
  const SigInPage({super.key});
  static const String id = "sigIn_page";
  @override
  State<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello Person"),
      ),
    );
  }
}
