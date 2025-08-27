import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/View/Designs/TextModel.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

class TaskTile extends StatelessWidget {
  String taskName;
  String taskType;
  TaskTile({required this.taskName,required this.taskType});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(""),
      onDismissed: (v)async{
         await context.read<MainDataProvider>().deleteTasks(taskName);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 400.w,
          height: 70.h,
          child: Card(

            elevation: 1,
            shadowColor: Colors.grey.withAlpha(128),
            color: Colors.black,
            child: ListTile(

              title: TextModel(str:taskName, textType: TextType.Title, ),
              subtitle: TextModel(str:taskType,textType: TextType.SubTitle),

            ),
          ),
        ),
      ),
    );
  }
}
