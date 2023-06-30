import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:sizer/sizer.dart';
class InformationScreen extends StatefulWidget {
  InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String data = '';

  fetchFileData() async{
    String responseText;
    responseText = await rootBundle.loadString("assets/what is leukemia.txt");
    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
              padding: PaddingManger.sidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h,),
                  Text(
                    "What is leukemia?",
                    style: GoogleFonts.dmSerifDisplay(textStyle: const TextStyle(color: Colors.black, fontSize: 22)),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(image: AssetImage("assets/LeukemiaWBC_share (1).jpg"),)
                    ),
                  ),
                  Text(data, style: GoogleFonts.ebGaramond(textStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                      )
                ]
              ),
            )
        ),
      ),
    );
  }
}
