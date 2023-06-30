import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leukemia_detection_app/view/resources/image_manager.dart';
import 'package:leukemia_detection_app/view/screens/onboarding_screen/onBoarding_screen.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState()
  {
    super.initState();
    Timer(const Duration(seconds:3), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnBoardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageManger.logo, width: 45.w).animate().fade().scale(delay: 2.seconds),
      ),
    );
  }
}

