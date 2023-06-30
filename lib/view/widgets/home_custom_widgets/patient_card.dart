import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/test_screen/result_screen.dart';
import 'package:leukemia_detection_app/view_model/data/remote/firebase_helper.dart';
import 'package:sizer/sizer.dart';

class PatientCard extends StatelessWidget {

  PatientModel patient;
  PatientCard(this.patient);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(patient))),
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
                      FirebaseHelper().deleteData('patients', patient.nationalId);

                    }, icon: const Icon(Icons.delete_outline_rounded, color: Colors.black,))
                  ],
                ),
                Center(child: Text("${patient.testResult}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400)))),
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
  }
}
