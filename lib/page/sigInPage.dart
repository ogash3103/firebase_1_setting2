import 'package:firebase_1_setting/page/SigUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import 'homePage.dart';

class SigInPage extends StatefulWidget {
  const SigInPage({Key? key}) : super(key: key);
  static const String id = "sigIn_page";

  @override
  State<SigInPage> createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _doSigIn() {
    String password = passwordController.text.toString().trim();
    String email = emailController.text.toString().trim();
    if (email.isEmpty || password.isEmpty) return;
    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(email, password).then((value) {
      responseSignIn(value!);
    });
  }

  void responseSignIn(User firebaseUser) async {
    Navigator.pushReplacementNamed(context, HomePage.id);
    setState(() {
      isLoading = false;
    });
  }

  void _callSignUpPage() {
    Navigator.pushReplacementNamed(context, SigUpPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // #email
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white54)),
                  ),
                ),
                const SizedBox(height: 10,),
                // #password
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white54)),
                  ),
                ),
                const SizedBox(height: 10,),
                // #signInBtn
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: GestureDetector(
                    onTap: _doSigIn,
                    child: const Center(child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account", style: TextStyle(color: Colors.white, fontSize: 16),),
                    const SizedBox(width: 7,),
                    GestureDetector(
                      onTap: _callSignUpPage,
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
            isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
