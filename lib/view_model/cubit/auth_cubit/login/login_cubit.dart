import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leukemia_detection_app/model/user_model.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:leukemia_detection_app/view_model/data/remote/firebase_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  
  FirebaseHelper firebase = FirebaseHelper();


  TextEditingController emailCtrl = TextEditingController(text: "omara@gmail.com");
  TextEditingController passwordCtrl = TextEditingController(text: "123456789");
  bool showPass = true;
  bool isChecked = false;


  void changePasswordVisibility() {
    showPass = !showPass;
    emit(PasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) {

    emit(LoginLoadingState());

    firebase.signInWithEmailAndPassword(email, password)
      .then((value) {
        emit(LoginSuccessState());

        Fluttertoast.showToast(
          msg: "login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
        );

        emit(GetUserdataLoadingState());
        firebase.getUserData(value.user!.uid).then((value) {
          currentUser = UserModel.fromJson(value);
          print(currentUser?.name);
          print(currentUser?.role);

          emit(GetUserdataSuccessState());
        }).catchError((error) {
          emit(GetUserdataErrorState());
          print(error.toString());
          Fluttertoast.showToast(
              msg: "Error when get data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
      }).catchError((error) {
        emit(LoginErrorState());
        print(error.toString());
        Fluttertoast.showToast(
            msg: "Error with email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
  }

}
