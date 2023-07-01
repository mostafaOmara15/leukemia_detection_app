import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:leukemia_detection_app/view/screens/auth/login_screen/login_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../view_model/data/local/cache_helper.dart';
import '../../../view_model/route/router.dart';
import '../../resources/color_manager.dart';

class OnBoardingScreen extends StatelessWidget {

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Get start',
      onFinish: () {
        CacheHelper.setBoolean("onBoarding", false);
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: ColorManager.blackColor,
      ),

      skipTextButton: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 18,
          color: ColorManager.blackColor,
          fontWeight: FontWeight.w400,
        ),
      ),

      controllerColor: ColorManager.blackColor,
      totalPage: 2,
      headerBackgroundColor: ColorManager.backgroundColor,
      pageBackgroundColor: ColorManager.backgroundColor,

      background: [
        SizedBox(
          height: 50.h,
          width: 48.h,
          child: Image.asset(
            'assets/logo.png',
            fit:BoxFit.fill,
            height: 30.h,
          ),
        ),
        SizedBox(
          height: 50.h,
          width: 48.h,
          child: Image.asset(
            'assets/logo.png',
            fit:BoxFit.fill,
            height: 30.h,
          ),
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60.h,
              ),
              Text(
                'Offers an additional insight.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:ColorManager.blackColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'This application was mainly designed to provide a new point of view as a way of coping with the rapid development of the Artificial intelligence field.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  <Widget>[
              SizedBox(
                height: 60.h,
              ),
              Text(
                'Disclaimer! This application does not provide medical advice.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.blackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'No material is intended to be a substitute for professional medical service',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}