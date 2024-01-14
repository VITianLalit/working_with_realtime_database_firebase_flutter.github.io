import 'package:dummy/Login&SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../post_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "LoginScreen",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 3),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(top: 3),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: (){
                        _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen())));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 70),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Text("SUBMIT", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1),)),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?"),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                            },
                            child: Text("SignUp", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
