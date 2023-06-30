import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leukemia_detection_app/view/resources/image_manager.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/layout_screen.dart';
import 'package:leukemia_detection_app/view/screens/auth/register_screen/register_screen.dart';
import 'package:leukemia_detection_app/view/screens/splash_screen/splash_screen.dart';
import 'package:leukemia_detection_app/view/widgets/cutom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../view_model/cubit/auth_cubit/login/login_cubit.dart';
import '../../../../view_model/cubit/auth_cubit/login/login_states.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/padding_manager.dart';
import '../../../widgets/custom_button/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if (state is GetUserdataSuccessState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppLayout()));
          }
        },
        builder: (BuildContext context, LoginStates states) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Form(
            key: loginCubit.loginKey,
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.h),
                  Image.asset(ImageManger.logo, width: 30.w,),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: Container(
                      padding: PaddingManger.sidePadding,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 3.5.h),
                            const Text(
                                "Login",
                                style: TextStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                            SizedBox(height: 3.5.h),
                            CustomTextFormField(
                              fieldCtrl: loginCubit.emailCtrl,
                              validate: (value) {
                                if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              withIcon: false,
                              fieldIcon: Icons.email_outlined,
                              isSecured: false,
                              fieldInput: TextInputType.name,
                              fieldHint: "Email",
                            ), // Email
                            SizedBox(height: 2.5.h,),
                            CustomTextFormField(
                              fieldCtrl: loginCubit.passwordCtrl,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Enter your Password';
                                }
                                else if (value.length < 8){
                                  return 'Password is too short.';
                                }
                                return null;
                              },
                              fieldIcon: Icons.lock_outline_rounded,
                              fieldHint: "Password",
                              fieldInput: TextInputType.visiblePassword,
                              isSecured: loginCubit.showPass,
                              withIcon: true,
                              showPass: () {
                                loginCubit.changePasswordVisibility();
                              },
                            ), // password
                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.7,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h,),
                            CustomButton(
                              title: "Login",
                              toDo: () {
                                if (loginCubit.loginKey.currentState!.validate()) {
                                  loginCubit.userLogin(email: loginCubit.emailCtrl.text,password: loginCubit.passwordCtrl.text);
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                      color: ColorManager.greyColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),

                                TextButton(
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        color: ColorManager.blackColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 2.5.h,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
