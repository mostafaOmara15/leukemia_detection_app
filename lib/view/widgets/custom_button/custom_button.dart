import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resources/color_manager.dart';

class CustomButton extends StatelessWidget {
  String? title;
  Function() toDo;
  Widget? child;

  CustomButton(
    {
      this.title,
      this.child,
      required this.toDo
    }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toDo,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 90.w,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: ColorManager.blackColor,
        ),
        child: Center(
          child: child ?? Center(
            child: Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
