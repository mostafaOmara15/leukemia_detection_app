import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leukemia_detection_app/model/user_model.dart';
import 'package:leukemia_detection_app/view_model/cubit/auth_cubit/register/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constant.dart';
import '../../../data/remote/firebase_helper.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  FirebaseHelper firebase = FirebaseHelper();

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nationalIdCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  bool showPass = true;
  bool confirmShowPass = true;
  String userRole = "";

  /// function to change password visibility
  void changePasswordVisibility() {
    showPass = !showPass;
    emit(PasswordVisibilityState());
  }
  void changeConfirmPasswordVisibility() {
    confirmShowPass = !confirmShowPass;
    emit(PasswordVisibilityState());
  }
  void selectingRadio(String value) {
    userRole = value;
    emit(RadioSelectionState());
  }

  void userRegister({required String userName, required String email, required String password, String? nationalId, required String userRole})
  {
    emit(RegisterLoadingState());
    firebase.createUserWithEmailAndPassword(email, password)
      .then((value) async {
        emit(RegisterSuccessState());
        Fluttertoast.showToast(
            msg: "Register success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        emit(CreationLoadingState());
        UserModel user = UserModel(name: userName, email: email, uId: value.user!.uid, nationalId: nationalId, role: userRole);
        firebase.setData("users", value.user!.uid, user.toMap())
          .then((value){
            emit(CreationSuccessState());
          }).catchError((error){
            emit(CreationErrorState(error));
            print(error.toString());
        });

        emit(GetUserdataLoadingState());
        await firebase.getUserData(value.user!.uid).then((value) {
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
      }
    ).catchError((error){
      emit(RegisterErrorState());
      print(error.toString());
      Fluttertoast.showToast(
          msg: "Register success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

}

