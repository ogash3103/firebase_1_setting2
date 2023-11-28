import 'package:firebase_1_setting/page/homePage.dart';
import 'package:firebase_1_setting/page/sigInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class SigUpPage extends StatefulWidget {
  const SigUpPage({super.key});
  static const String id = "sigUp_page";
  @override
  State<SigUpPage> createState() => _SigUpPageState();
}

class _SigUpPageState extends State<SigUpPage> {
  var isLoading = false;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  void _doSignUP(){
    String fullName = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cPassword= confirmPasswordController.text.toString().trim();

    if(fullName.isEmpty || email.isEmpty || password.isEmpty) return;
    if(cPassword != password){
      print("error message");
      return;
    }
    setState(() {
      isLoading = true;
    });
    AuthService.signUpUser(fullName, email, password).then((value) => {
      responseSignUp(value!),
  });
  }
  void responseSignUp(User  firebaseUser) async{
    Navigator.pushReplacementNamed(context, HomePage.id);
    setState(() {
      isLoading = false;
    });
  }
  void _callSignInPage() {
    Navigator.pushReplacementNamed(context, SigInPage.id);
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
                Color.fromRGBO(131, 58, 180, 1)
              ]
          ),
        ),
        child:  Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // #Fullname
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: fullNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "FullName",
                        border: InputBorder.none,

                        hintStyle: TextStyle(fontSize: 18, color: Colors.white54)
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
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

                        hintStyle: TextStyle(fontSize: 18, color: Colors.white54)
                    ),
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
                  child:  TextField(
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white54)
                    ),
                  ),
                ),//
                const SizedBox(height: 10,),
                // #Cpassword
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child:  TextField(
                    controller: confirmPasswordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Conform Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white54)
                    ),
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
                      onTap: _doSignUP,
                      child: const Center(child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
                    )
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account", style: TextStyle(color: Colors.white, fontSize: 16),),
                    const SizedBox(width: 7,),
                    GestureDetector(
                      onTap: _callSignInPage,
                      child:  const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                    ),

                  ],
                ),
              ],
            ),
            isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox.shrink()
          ],
        )
      ),
    );
  }
}
