import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';
import 'package:leukemia_detection_app/view/resources/color_manager.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/home_screen/patients_history/report_screen.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:leukemia_detection_app/view_model/data/remote/firebase_helper.dart';
import 'package:sizer/sizer.dart';
import '../../test_screen/result_screen.dart';

class PatientsHistory extends StatefulWidget {
  const PatientsHistory({Key? key}) : super(key: key);

  @override
  State<PatientsHistory> createState() => _PatientsHistoryState();
}

class _PatientsHistoryState extends State<PatientsHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.backgroundColor,
            title: const Text("Patients history",
                style: TextStyle(color: Colors.black, fontSize: 22)
            ),
        ),
        body: FutureBuilder(
          future: FirebaseHelper().getPatientsByExaminerId(currentUser?.uId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.black,));
            }
            else if (snapshot.hasError) {
              return const Center(child: Text('Failed to get patients'));
            }
            else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No data', style: TextStyle(fontSize: 22)));
            }
            else {
              final patients = snapshot.data as List<PatientModel>;

              return Padding(
                padding: PaddingManger.sidePadding,
                child: ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (context, index) {

                    final patient = patients[index];

                    return Column(
                      children: [

                        InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen(patient))),

                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 15.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.black, width: 2)
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${patient.name}",style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),

                                    IconButton(onPressed: (){
                                      FirebaseHelper().deleteData('patients', patient.nationalId).then((value)
                                      {
                                        setState(() {
                                        });
                                      });
                                    }, icon: const Icon(Icons.delete_outline_rounded, color: Colors.black,))
                                  ],
                                ),

                                Center(child: Text(patient.testResult ?? "undefined result", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400)))),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_month, color: Colors.black, size: 20),
                                        Text("${patient.testDate}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.watch_later_outlined, color: Colors.black, size: 20),
                                        Text("${patient.testTime}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
