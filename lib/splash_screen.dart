import 'package:demo_course_video/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    print(">>splash screen init");

    Future.delayed(const Duration(seconds: 3), () {
      context.push("/${RouteName.homescreen}");
    },);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}