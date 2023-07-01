import 'package:flutter/material.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/home_screen/health_profile/health_profile.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/home_screen/patients_history/patients_history.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/layout_screen.dart';
import 'package:leukemia_detection_app/view_model/route/router.dart';
import '../../view/screens/app_layout/test_screen/test_screen.dart';
import '../../view/screens/auth/login_screen/login_screen.dart';
import '../../view/screens/auth/register_screen/register_screen.dart';
import '../../view/screens/onboarding_screen/onboarding_screen.dart';
import '../../view/screens/splash_screen/splash_screen.dart';

Route<dynamic> onGenerate(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AppRoutes.splashRoute:
      return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: routeSettings);

    case AppRoutes.onBoardingRoute:
      return MaterialPageRoute(builder: (_) => const OnBoardingScreen(), settings: routeSettings);

    case AppRoutes.loginScreenRoute:
      return MaterialPageRoute(builder: (_) => const LoginScreen(), settings: routeSettings);

    case AppRoutes.registerScreenRoute:
      return MaterialPageRoute(builder: (_) => const RegisterScreen(), settings: routeSettings);

    case AppRoutes.layoutScreenRoute:
      return MaterialPageRoute(builder: (_) => const AppLayout(), settings: routeSettings);

    case AppRoutes.testScreenRoute:
      return MaterialPageRoute(builder: (_) => TestScreen(), settings: routeSettings);

    case AppRoutes.patientHistoryScreenRoute:
      return MaterialPageRoute(builder: (_) => const PatientsHistory(), settings: routeSettings);

    case AppRoutes.healthProfileScreenRoute:
      return MaterialPageRoute(builder: (_) => HealthProfile(), settings: routeSettings);

    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: routeSettings);
  }
}