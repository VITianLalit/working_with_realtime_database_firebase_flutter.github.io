
import 'package:dummy/splash_screen/splash_service.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  SplashService splash = new SplashService();
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Text(
            "FireBase",
            style: TextStyle(
                fontSize: 40,
                color: Colors.yellow,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
