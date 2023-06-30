import 'package:flutter/material.dart';
import 'package:leukemia_detection_app/view/resources/color_manager.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:leukemia_detection_app/view_model/constant.dart';
import '../../../widgets/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHigh = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController emailCtrl = TextEditingController(text: currentUser?.email);
    TextEditingController roleCtrl = TextEditingController(text: currentUser?.role);
    TextEditingController nationalIdCtrl = TextEditingController(text: currentUser?.nationalId);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHigh * 0.29,
              child: Stack(
                children: [
                 Container(
                   height: screenHigh * 0.22,
                     //color: ColorManager.backgroundColor,
                     child: Image.asset('assets/profile_background.jpg', fit: BoxFit.cover)
                 ),
                  const Align(
                   alignment: Alignment.bottomCenter,
                   child: CircleAvatar(
                     radius: 62,
                     backgroundColor: Colors.black,
                     child: CircleAvatar(
                       backgroundColor: ColorManager.backgroundColor,
                       backgroundImage: AssetImage('assets/profile_pic.jpg',),
                       radius: 60,
                     ),
                   ),
                 )
               ]
              ),
            ),
            SizedBox(height: screenHigh * 0.02,),
            Text("${currentUser?.name}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
            SizedBox(height: screenHigh * 0.02,),
            Padding(
              padding: PaddingManger.sidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black)),
                  SizedBox(height: screenHigh * 0.02,),
                  CustomTextField(fieldCtrl: emailCtrl, fieldIcon: Icons.email_outlined),

                  SizedBox(height: screenHigh * 0.02,),
                  const Text("Role", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black)),
                  SizedBox(height: screenHigh * 0.02,),
                  CustomTextField(fieldCtrl: roleCtrl, fieldIcon: Icons.business_sharp),

                  SizedBox(height: screenHigh * 0.02,),
                  const Text("National ID", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black)),
                  SizedBox(height: screenHigh * 0.02,),
                  CustomTextField(fieldCtrl: nationalIdCtrl, fieldIcon: Icons.onetwothree_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
