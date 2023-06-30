import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/view_model/cubit/report_cubit/report_states.dart';
import 'package:leukemia_detection_app/view_model/data/remote/firebase_helper.dart';
import 'package:sizer/sizer.dart';
import '../../../../../model/patient_model.dart';
import '../../../../../view_model/constant.dart';
import '../../../../../view_model/cubit/report_cubit/report_cubit.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/padding_manager.dart';

class ReportScreen extends StatelessWidget {

  PatientModel? patient ;
  ReportScreen (this.patient);

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (context) => ReportCubit(),
        child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (BuildContext context, ReportStates states){},
            builder: (BuildContext context, ReportStates states){
              ReportCubit reportCubit = ReportCubit.get(context);

              reportCubit.commentCtrl.text = patient?.examinerComment ?? "";

              return SafeArea(
                child: Scaffold(
                  body: Padding(
                    padding: PaddingManger.sidePadding,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3.h,),
                          const Text("Result Report...", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),),
                          SizedBox(height: 3.h,),
                          Text("Name:  ${patient?.name}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h,),
                          Text("Age:  ${patient?.age}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h,),
                          Text("Gender:  ${patient?.gender}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h,),
                          Text("NationalId:  ${patient?.nationalId}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h,),
                          Text("Date:  ${patient?.testDate}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h,),
                          Text("Time:  ${patient?.testTime}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h,),
                          Text("Result:  ${patient?.testResult ?? "The Result has not yet been determined"}",
                              style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))
                          ),

                          SizedBox(height: 2.h,),
                          Text("Sample:", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                          SizedBox(height: 1.h),
                          SizedBox(
                            height: 30.h,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  patient!.bloodSample ?? "",
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 2.h,),

                          currentUser?.role == 'organization'
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Comment:", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                              SizedBox(height: 1.h),
                              TextField(
                                controller: reportCubit.commentCtrl,

                                cursorColor: ColorManager.blackColor,
                                keyboardType: TextInputType.multiline,
                                autocorrect: currentUser?.role == 'organization' ? true : false,
                                textCapitalization: TextCapitalization.sentences,
                                style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                                maxLines: 10,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: ColorManager.blackColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1, color: ColorManager.blackColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ],
                          )

                          : const SizedBox(),
                          SizedBox(height: 2.h,),

                          reportCubit.updateButton == true
                          ? Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  reportCubit.updatePatientData(patient!).then((value) => Navigator.pop(context));
                                },

                                style: ElevatedButton.styleFrom(
                                  primary: ColorManager.blackColor,
                                  padding: EdgeInsets.all(15),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                                child: Text("update changes", style: TextStyle(fontSize: 12.sp))
                            ),
                          )
                          : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}
