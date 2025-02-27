import 'dart:developer';

import 'package:demo_course_video/core/routes/route_name.dart';
import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/presentation/cubit/internet/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool? hasInternet;

  @override
  void initState() {
    super.initState();

    navigate();
  }

  void navigate() async{
    hasInternet = await context.read<InternetCubit>().checkInternetAccess();
    setState(() {log("Internet Test: $hasInternet", name: "SplashScreen");});

    if(hasInternet!){
       Future.delayed(const Duration(seconds: 3), () {
        context.pushReplacementNamed(RouteName.homescreen);
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: hasInternet??false 
          ? const Center(
              child: Text("Splash Screen"),
            )
          : GestureDetector(
              onTap: () {
                navigate();
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 40, color: AppColor.primaryColor,),
        
                  SizedBox(height: 20,),
        
                  Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}