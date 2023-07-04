import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/test_screen/result_screen.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import 'package:leukemia_detection_app/view_model/cubit/test_cubit/test_cubit.dart';
import 'package:leukemia_detection_app/view_model/cubit/test_cubit/test_states.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/cutom_text_form_field.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String currentDate = DateFormat('dd-MMM-yyy').format(DateTime.now());
    String currentTime = TimeOfDay.now().format(context).toString();

    return BlocProvider(
      create: (context) => TestCubit(),
      child: BlocConsumer<TestCubit, TestStates>(
        listener: (BuildContext context, TestStates state){},
        builder: (BuildContext context, TestStates state){
          TestCubit testCubit = TestCubit.get(context);
          return Form(
            key: testCubit.testKey,
            child: Scaffold(
              body: Padding(
                padding: PaddingManger.sidePadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h,),
                      const Text("Patient Information...", style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500),),
                      SizedBox(height: 4.h,),
                      const Text("Name:", style: TextStyle(fontSize: 18, color: Colors.black),),
                      SizedBox(height: 2.h,),
                      CustomTextFormField(
                        fieldCtrl: testCubit.nameCtrl,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter patient name';
                          }
                          return null;
                        },
                        fieldIcon: Icons.person, fieldHint: "Name",
                        fieldInput: TextInputType.name, isSecured: false, withIcon: false,
                      ),
                      SizedBox(height: 3.h),
                      const Text("Age:", style: TextStyle(fontSize: 18, color: Colors.black),),
                      SizedBox(height: 2.h,),
                      CustomTextFormField(
                        fieldCtrl: testCubit.ageCtrl,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter the patient Age';
                          }
                          return null;
                        },
                        fieldIcon: Icons.watch_later_outlined, fieldHint: "Age",
                        fieldInput: TextInputType.number, isSecured: false, withIcon: false,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Gender:", style: TextStyle(fontSize: 18, color: Colors.black),),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Radio(
                                      value: "Male",
                                      groupValue: testCubit.patientGender,
                                      activeColor: Colors.black,
                                      onChanged: (value) {testCubit.selectingGender(value!);}
                                  ),
                                  const Expanded(
                                    child: Text(
                                        "Male",
                                        style: TextStyle(
                                            color: ColorManager.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Radio(
                                      value: "Female",
                                      groupValue: testCubit.patientGender ,
                                      activeColor: Colors.black,
                                      onChanged: (value) {
                                        testCubit.selectingGender(value!);
                                      }
                                  ),
                                  const Expanded(
                                    child: Text(
                                        "Female",
                                        style: TextStyle(
                                            color: ColorManager.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]
                      ),

                      SizedBox(height: 2.h),

                      const Text("National ID:", style: TextStyle(fontSize: 18, color: Colors.black),),
                      SizedBox(height: 2.h,),
                      CustomTextFormField(
                        fieldCtrl: testCubit.nationalIdCtrl,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter your username';
                          }
                          return null;
                        },
                        fieldIcon: Icons.onetwothree_rounded,
                        fieldHint: "National ID",
                        fieldInput: TextInputType.number,
                        isSecured: false,
                        withIcon: false,
                      ),

                      SizedBox(height: 2.h),

                      const Text("Blood sample:", style: TextStyle(fontSize: 18, color: Colors.black),),
                      SizedBox(height: 2.h,),

                      testCubit.pickedImage == null
                      ? const SizedBox()
                      : SizedBox(
                          height: 30.h,
                          child: Center(
                            child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(
                                    testCubit.pickedImage!,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                          ),
                        ),

                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          ElevatedButton(
                              onPressed: ()async{
                                testCubit.pickImageFromGallery();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: ColorManager.blackColor,
                                padding: EdgeInsets.all(15),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                              ),
                              child: Text("Pick the blood pic", style: TextStyle(fontSize: 12.sp))
                          ),
                          testCubit.pickedImage == null
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: ()async{
                                testCubit.unselectImage();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: ColorManager.blackColor,
                                padding: const EdgeInsets.all(15),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                              ),
                              child: Text("Unpick", style: TextStyle(fontSize: 12.sp))
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h,),

                      Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (testCubit.testKey.currentState!.validate()) {
                                  await testCubit.fillPatientData(
                                    testCubit.nameCtrl.text,
                                    testCubit.ageCtrl.text,
                                    testCubit.patientGender,
                                    currentDate,
                                    currentTime,
                                    testCubit.nationalIdCtrl.text,
                                  ).then((value){
                                    print(currentPatient?.toMap());
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(currentPatient)));
                                  });

                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: ColorManager.blackColor,
                              padding: EdgeInsets.all(15),
                              elevation: 3,
                              shape: RoundedRectangleBorder( //to set border radius to button
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            child: Text("Show result", style: TextStyle(fontSize: 12.sp))
                        ),
                      ),
                      SizedBox(height: 5.h,),
                    ]
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}