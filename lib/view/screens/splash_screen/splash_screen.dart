import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leukemia_detection_app/view/resources/image_manager.dart';
import 'package:leukemia_detection_app/view/screens/onboarding_screen/onBoarding_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../view_model/data/local/cache_helper.dart';
import '../../../view_model/route/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool onBoarding = CacheHelper.getBoolean("onBoarding") == null
      ? true
      : false;

  @override
  void initState()
  {
    super.initState();
    if(onBoarding == true){
      Timer(const Duration(seconds:3), () => Navigator.pushReplacementNamed(context, AppRoutes.onBoardingRoute,));
    }
    else{
      Timer(const Duration(seconds:3), () => Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute,));
    }
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

