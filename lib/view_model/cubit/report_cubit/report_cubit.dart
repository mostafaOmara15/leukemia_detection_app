import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';
import 'package:leukemia_detection_app/view_model/cubit/report_cubit/report_states.dart';
import '../../data/remote/firebase_helper.dart';


class ReportCubit extends Cubit<ReportStates>{
  ReportCubit(): super(ReportInitialState());

  static ReportCubit get(context) => BlocProvider.of(context);

  TextEditingController commentCtrl = TextEditingController();
  bool updateButton = true;

  void showUpdateButton(String? comment){
    print("hi");
    emit(ShowButtonState());
    if(comment != commentCtrl.text){
      updateButton = true;
      emit(ShowButtonState());
    }
    else {
      updateButton = false;
      emit(HideButtonState());
    }
  }

  Future<void> updatePatientData(PatientModel patient) async {
    patient!.examinerComment = commentCtrl.text;
    FirebaseHelper().updateData('patients', patient?.nationalId, patient!.toMap());
  }
}