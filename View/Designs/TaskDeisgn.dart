import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Model/SelectedBorderModel.dart';
import 'package:todo_app/View/Designs/TextModel.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

class TaskDesign extends StatelessWidget {
  bool selected;
  int index;
  Color taskColor;

  TaskDesign({required this.taskColor, required this.index,required this.selected});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(30.r),
        onTap: () {
          // model.select(context, index);
          context.read<SelectedBorderModel>().select(index);
        },
        child: Container(
          // margin: EdgeInsets.all(15),
          width: 150.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: taskColor,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              width: 1,
              color: selected
                  ? Colors.blue
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(context.read<MainDataProvider>().taskIcons[index], color: Colors.white70, size: 100.r),
                SizedBox(height: 20.h),
                TextModel(str: context.read<MainDataProvider>().taskNames[index], textType: TextType.Title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
