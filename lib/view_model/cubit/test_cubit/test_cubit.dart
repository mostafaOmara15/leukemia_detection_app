import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:leukemia_detection_app/view_model/cubit/test_cubit/test_states.dart';
import 'package:leukemia_detection_app/view_model/data/remote/firebase_helper.dart';

class TestCubit extends Cubit<TestStates>{
  TestCubit(): super(TestInitialState());

  static TestCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> testKey = GlobalKey<FormState>();
  File? pickedImage;
  ImagePicker picker = ImagePicker();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController nationalIdCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  String? patientGender ;
  String? bloodSample ;


  void selectingGender(String value) {
    patientGender = value;
    emit(SelectGenderState());
  }

  Future<void> pickImageFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    else {
      pickedImage = File(image.path);
      emit(PickSampleState());
    }
  }

  void unselectImage(){
    pickedImage = null;
    emit(UnPickSampleState());
  }

  Future<void> getSampleUrl() async{
    await FirebaseHelper().uploadImage(pickedImage).then((value) async {
      print(value);
      bloodSample = value!;
    });
  }

  Future<void> fillPatientData(String name, String age, String? gender, String testDate, String testTime, String nationalId) async{
    await getSampleUrl().then((value){
      currentPatient = PatientModel(name: name, age: age, gender: gender, testDate: testDate, testTime: testTime, nationalId: nationalId, examiner: currentUser!.uId, bloodSample: bloodSample);
    });
  }
}