

import 'dart:async';

import 'package:dummy/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Login&SignUp/login_screen.dart';

class SplashService {
  void isLogin(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen())));
    }else{
      Timer(Duration(seconds: 3), () => MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
