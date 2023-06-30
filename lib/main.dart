import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leukemia_detection_app/view/resources/color_manager.dart';
import 'package:leukemia_detection_app/view/screens/splash_screen/splash_screen.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:leukemia_detection_app/view_model/cubit/auth_cubit/login/login_cubit.dart';
import 'package:leukemia_detection_app/view_model/cubit/auth_cubit/register/register_cubit.dart';
import 'package:leukemia_detection_app/view_model/cubit/block_observer.dart';
import 'package:leukemia_detection_app/view_model/data/local/cache_helper.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManager.backgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorManager.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers:[
              BlocProvider(create: (context) => LoginCubit()),
              BlocProvider(create: (context) => RegisterCubit()),
            ],
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: ColorManager.backgroundColor, fontSize: 20),
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: ColorManager.backgroundColor,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.transparent,
                selectedItemColor: ColorManager.blackColor,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                elevation: 0
              ,
              )
          ),
          home: const SplashScreen(),

          // initialRoute: AppRoutes.splashRoute,
          // onGenerateRoute: onGenerate,
        )
        );
      },
    );
  }
}
