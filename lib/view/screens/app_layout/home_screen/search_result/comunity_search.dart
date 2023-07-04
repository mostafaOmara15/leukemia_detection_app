import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:sizer/sizer.dart';
import '../../../../../view_model/data/remote/firebase_helper.dart';
import '../../../../resources/color_manager.dart';
import '../patients_history/report_screen.dart';

class CommunitySearch extends StatefulWidget {
  const CommunitySearch({Key? key}) : super(key: key);

  @override
  State<CommunitySearch> createState() => _CommunitySearchState();

}

class _CommunitySearchState extends State<CommunitySearch> {
  final TextEditingController controller = TextEditingController(text: currentUser!.role == "community" ? currentUser?.nationalId : '');
  String? searchText =  currentUser?.nationalId ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: currentUser!.role == "community"
                  ? const Text("know your test result", style: TextStyle(color: Colors.black))
                  : const Text("Search for a patient result", style: TextStyle(color: Colors.black))
          ),
          body: Padding(
            padding: PaddingManger.sidePadding,
            child: Column(
              children: [
                SizedBox(height: 2.h,),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  readOnly: currentUser!.role == "community" ? true : false,
                  onSubmitted: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter patient's national ID",
                    prefixIcon: const Icon(Icons.search_rounded),
                    prefixIconColor: Colors.black,

                    enabledBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(width: 1, color: ColorManager.blackColor),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color: ColorManager.blackColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('patients')
                          .where('nationalId', isEqualTo: currentUser?.nationalId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              PatientModel patient = PatientModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>?);
                              print(patient);
                              return Column(
                                children: [
                                  SizedBox(height: 2.h,),
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
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
