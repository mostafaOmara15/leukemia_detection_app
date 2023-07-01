import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:leukemia_detection_app/view_model/route/router.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/color_manager.dart';

class ResultScreen extends StatelessWidget {

  PatientModel? patient ;
  ResultScreen ( this.patient);

  TextEditingController commentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    commentCtrl.text = patient?.examinerComment ?? "";
    print(patient);
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
                Text("Name:  ${patient!.name}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),
                Text("Age:  ${patient!.age}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),
                Text("Gender:  ${patient!.gender}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),
                Text("NationalId:  ${patient!.nationalId}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),
                Text("Date:  ${patient!.testDate}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),
                Text("Time:  ${patient!.testTime}", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),
                Text("Result:  ${patient!.testResult ?? "The Result has not yet been determined"}",
                    style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))
                ),

                SizedBox(height: 3.h,),

                Text("Sample:", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                SizedBox(height: 1.h,),

                patient!.bloodSample != null
                ? SizedBox(
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
                )
                :const SizedBox(),


                currentUser?.role == 'organization'
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Comment:", style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500))),
                    SizedBox(height: 1.h),
                    TextField(
                      controller: commentCtrl,

                      cursorColor: ColorManager.blackColor,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
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
                : Column(
                  children: [
                    Text("Please go to the nearest hospital or clinic to monitor your health condition.",
                        style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))
                    ),
                    SizedBox(height: 3.h,),

                    Text("--> If you don't know any clinics, you can get some help from Veseeta.",
                        style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))
                    ),
                    SizedBox(height: 2.h,),
                    InkWell(
                        child: Center(
                          child: SizedBox(
                            height: 11.h,
                            width: 40.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                "assets/veseeta.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async{
                          Uri url = Uri.parse('https://www.vezeeta.com/en/doctor/oncology/egypt');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }
                    ),

                    SizedBox(height: 3.h,),
                    Text("--> If you don't know any Hospital, you can get some help from Google Maps.",
                        style: GoogleFonts.fragmentMono(textStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))
                    ),
                    SizedBox(height: 2.h,),
                    InkWell(
                        child: Center(
                          child: SizedBox(
                            height: 11.h,
                            width: 40.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                "assets/google-map.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async{
                          Uri url = Uri.parse('https://www.google.com/maps/search/cancer/@31.0448092,31.3903714,14.59z?entry=ttu');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }
                    ),
                  ],
                ),

                SizedBox(height: 2.h,),

                Center(
                  child: ElevatedButton(
                      onPressed: () async{
                        currentPatient!.examinerComment = commentCtrl.text;
                        await FirebaseFirestore.instance.collection('patients').doc().set(currentPatient!.toMap())
                          .then((value){
                            Navigator.pushReplacementNamed(context, AppRoutes.layoutScreenRoute);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.blackColor,
                        padding: const EdgeInsets.all(15),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      child: Text("Save result", style: TextStyle(fontSize: 12.sp))
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

