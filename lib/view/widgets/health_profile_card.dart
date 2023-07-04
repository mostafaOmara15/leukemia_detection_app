import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HealthCard extends StatelessWidget {

  String cardIcon;
  String cardTitle;
  String measureUnit;
  TextEditingController cardCtrl;
  HealthCard({required this.cardIcon, required this.cardTitle, required this.cardCtrl, required this.measureUnit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.h,
      width: 60.w,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 6.w,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 5.5.w,
                  child: Image.asset(cardIcon, width: 7.w),
                ),
              ),
              SizedBox(width: 2.w,),
              Center(child: Text(cardTitle, style: const TextStyle(fontSize: 20, color: Colors.white),))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 12.w,
                child: const TextField(
                  cursorColor: Colors.red,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: '0.0',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(measureUnit, style: const TextStyle(fontSize: 18, color: Colors.grey),)
            ],
          )
        ],
      ),
    );
  }
}
