import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class CustomTextField extends StatelessWidget {

  TextEditingController fieldCtrl;
  IconData fieldIcon;

  CustomTextField
      (
        {
          required this.fieldCtrl,
          required this.fieldIcon,
        }
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: fieldCtrl,
      cursorColor: ColorManager.blackColor,
      decoration: InputDecoration(
        prefixIcon: Icon(fieldIcon),
        prefixIconColor: Colors.black,

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
    );
  }
}
