import 'dart:convert';
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
import 'package:http/http.dart' as http;


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

  String prediction = '';


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

  Future sendImage() async {
    if (pickedImage == null) {
      print('No image selected.');
      return;
    }

    // Replace this URL with the API endpoint that expects an image file
    final url = Uri.parse('http://192.168.1.5:8080/classify_image');

    try {
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', pickedImage!.path));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        emit(GetResponseState());
        final result = jsonDecode(response.body);
          prediction = result.trim();
          return [result.trim()];
      } else {
        throw Exception('Failed to connect to API');
      }
      // if (response.statusCode == 200) {
      //   final responseData = await response.stream.transform(utf8.decoder).join();
      //     prediction = responseData;
      //   print(prediction);
      //     emit(GetResponseState());
      // } else if (response.statusCode == 500){
      //   prediction = "INTERNAL SERVER ERROR";
      //   print(prediction);
      //   emit(GetResponseState());
      // }
      // else {
      //   print('Error: ${response.reasonPhrase}');
      //   print(prediction);
      //   prediction = "undefined";
      //   emit(GetResponseState());
      // }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fillPatientData(String name, String age, String? gender, String testDate, String testTime, String nationalId) async{
    await getSampleUrl().then((value) async {
      await sendImage().then((value){
        currentPatient = PatientModel(name: name, age: age, gender: gender, testDate: testDate, testTime: testTime, nationalId: nationalId, examiner: currentUser!.uId, bloodSample: bloodSample, testResult: prediction);
      }).catchError((e) {print (e);});
    }).catchError((e) {print (e);});
  }
}