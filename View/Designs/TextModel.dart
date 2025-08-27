import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextModel extends StatelessWidget {
  String str;
  Color? color;
  TextType textType;
  TextModel({required this.str, required this.textType, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(
        color: color ?? Colors.white70,
        fontWeight: textType == TextType.SubTitle
            ? FontWeight.w300
            : (textType == TextType.Title ? FontWeight.w500 : FontWeight.w700),
        fontSize: textType == TextType.SubTitle
            ? 12.sp
            : (textType == TextType.Title ? 17.sp : 20.sp),
      ),
    );
  }
}

enum TextType { Header, Title, SubTitle }
