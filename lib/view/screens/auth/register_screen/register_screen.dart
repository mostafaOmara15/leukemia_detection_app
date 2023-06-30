import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leukemia_detection_app/view/resources/image_manager.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/home_screen/home_screen.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/layout_screen.dart';
import 'package:leukemia_detection_app/view/screens/auth/login_screen/login_screen.dart';
import 'package:leukemia_detection_app/view/widgets/cutom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../view_model/cubit/auth_cubit/register/register_cubit.dart';
import '../../../../view_model/cubit/auth_cubit/register/register_states.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/padding_manager.dart';
import '../../../widgets/custom_button/custom_button.dart';
import '../../splash_screen/splash_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (BuildContext context, RegisterStates state) {
            if(state is GetUserdataSuccessState){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppLayout()));
              Fluttertoast.showToast(
                  msg: "Data obtained successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
            else if(state is CreationErrorState){
              Fluttertoast.showToast(
                  msg: "Error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },
          builder: (BuildContext context, RegisterStates states) {

            RegisterCubit registerCubit = RegisterCubit.get(context);
            return Form(
              key: registerCubit.registerKey,
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Image.asset(ImageManger.logo, width: 30.w,),
                    SizedBox(height: 6.h),
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
                              SizedBox(height: 3.h),
                              const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: ColorManager.blackColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                              SizedBox(height: 3.h),
                              CustomTextFormField(
                                fieldCtrl: registerCubit.userNameCtrl,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter your username';
                                  }
                                  return null;
                                },
                                withIcon: false,
                                fieldIcon: Icons.person,
                                isSecured: false,
                                fieldInput: TextInputType.name,
                                fieldHint: "Username",
                              ), ///userName text-field
                              SizedBox(height: 2.5.h,),
                              CustomTextFormField(
                                fieldCtrl: registerCubit.emailCtrl,
                                validate: (value) {
                                  if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
                                    return 'Invalid Email';
                                  }
                                  return null;
                                },
                                withIcon: false,
                                fieldIcon: Icons.email_outlined,
                                isSecured: false,
                                fieldInput: TextInputType.emailAddress,
                                fieldHint: "Email",
                              ), ///email text-field
                              SizedBox(height: 2.5.h,),
                              CustomTextFormField(
                                fieldCtrl: registerCubit.passwordCtrl,
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
                                isSecured: registerCubit.showPass,
                                withIcon: true,
                                showPass: () {
                                  registerCubit.changePasswordVisibility();
                                },
                              ), ///password text-field
                              SizedBox(height: 2.5.h,),
                              CustomTextFormField(
                                fieldCtrl: registerCubit.confirmPasswordCtrl,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter your password again';
                                  }
                                  if (registerCubit.confirmPasswordCtrl.text != registerCubit.passwordCtrl.text) {
                                    return 'not match';
                                  }
                                  return null;
                                },
                                fieldIcon: Icons.lock_outline_rounded,
                                fieldHint: "Confirm password",
                                fieldInput: TextInputType.visiblePassword,
                                isSecured: registerCubit.confirmShowPass,
                                withIcon: true,
                                showPass: () {
                                  registerCubit.changeConfirmPasswordVisibility();
                                },
                              ), ///confirm password text-field
                              SizedBox(height: 2.5.h,),
                              CustomTextFormField(
                                fieldCtrl: registerCubit.nationalIdCtrl,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter your National ID';
                                  }
                                  return null;
                                },
                                fieldIcon: Icons.onetwothree_rounded,
                                fieldHint: "National ID",
                                fieldInput: TextInputType.number,
                                isSecured: false,
                                withIcon: false,
                              ),
                              SizedBox(height: 2.5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: "community",
                                            groupValue: registerCubit.userRole ,
                                            activeColor: Colors.black,
                                            onChanged: (value) {
                                              registerCubit.selectingRadio(value!);
                                              print(registerCubit.userRole = value);
                                            }
                                        ),
                                        const Expanded(
                                          child: Text(
                                              "community",
                                              style: TextStyle(
                                                  color: ColorManager.blackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: "organization",
                                            groupValue: registerCubit.userRole,
                                            activeColor: Colors.black,
                                            onChanged: (value) {
                                              registerCubit.selectingRadio(value!);
                                              print(registerCubit.userRole = value);
                                            }
                                        ),
                                        const Expanded(
                                            child: Text(
                                              "organization",
                                              style: TextStyle(
                                                color: ColorManager.blackColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400
                                              )
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                              ),

                              SizedBox(height: 6.h,),
                              CustomButton(
                                title: "Register",
                                toDo: () {
                                  if (registerCubit.registerKey.currentState!.validate()) {
                                    registerCubit.userRegister(
                                      userName: registerCubit.userNameCtrl.text,
                                      email: registerCubit.emailCtrl.text,
                                      password: registerCubit.passwordCtrl.text,
                                      nationalId: registerCubit.nationalIdCtrl.text,
                                      userRole: registerCubit.userRole
                                    );
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "You have an account? ",
                                    style: TextStyle(
                                        color: ColorManager.greyColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  TextButton(
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                                    },
                                  ),
                                ],
                              ),
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
