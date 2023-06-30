import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class CustomTextFormField extends StatelessWidget {

  TextEditingController fieldCtrl;
  final Function? validate;
  bool withIcon;
  IconData fieldIcon;
  bool isSecured;
  Function()? showPass;
  TextInputType fieldInput;
  String? fieldHint;
  Function()? checkFields;

  CustomTextFormField
  (
    {
      this.validate,
      required this.fieldCtrl,
      required this.withIcon,
      required this.fieldIcon,
      required this.isSecured,
      required this.fieldInput,
      this.fieldHint,
      this.showPass,
      this.checkFields
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldCtrl,
      validator: (p) => validate!(p),
      obscureText: isSecured,
      keyboardType: fieldInput,
      cursorColor: ColorManager.blackColor,

      decoration: InputDecoration(
        prefixIcon: Icon(fieldIcon),
        prefixIconColor: Colors.black,
        hintText: fieldHint,
        hintStyle: const TextStyle(color: ColorManager.greyColor),

        suffixIcon: withIcon
            ? IconButton(
            onPressed: showPass,
            icon: isSecured
                ? const Icon(
                Icons.visibility_off,
                color: ColorManager.greyColor
            )
                : const Icon(
                Icons.visibility,
                color: ColorManager.blackColor
            )
        )
            : null,

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
