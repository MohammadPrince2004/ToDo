import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/View/Designs/TextModel.dart';

class DrawerBt extends StatelessWidget {
  IconData iconData;
  String txt;
  Function onPressed;
  DrawerBt({required this.iconData, required this.txt,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50.h,
        child: MaterialButton(
          onPressed: () {onPressed();},
          child: Row(
            children: [
              Icon(iconData,color: Colors.white70,),
              SizedBox(width: 5.w),
              TextModel(str: txt, textType: TextType.Title,color: Colors.white70,),
            ],
          ),
        ),
      ),
    );
  }
}
