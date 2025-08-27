import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/View/Designs/PageDesign.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

import '../Designs/TextModel.dart';
import 'MainPage.dart';

class TaskPage extends StatelessWidget {
  bool clicked = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int indexType;
  TextEditingController taskName=TextEditingController();
  TaskPage({required this.indexType});
  @override
  Widget build(BuildContext context) {
    print(indexType);
    return PageDesign(
      pageType: PageType.TaskPage,
      child: Form(

        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: Colors.white12,
                radius: 75.r,
                child: Icon(Icons.add_task, size: 75.r, color: Colors.white54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 300.w,
                height: 70.h,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  onTap: (){
                    clicked = true;
                  },
                  validator: (value){
                    if(value==""&&clicked){
                      return "Please , Enter The Task !!";
                    }
                  },
                  controller: taskName,
                  cursorColor: Colors.white70,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    label: Text(
                      "Name Of The Task",
                      style: TextStyle(color: Colors.white70),
                    ),
                    // counterStyle: TextStyle(color:Colors.white70),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.shade400),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.h),
            SizedBox(
              height: 40.h,
              width: 100.w,
              child: MaterialButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    if(taskName.text!=""){
                      context.read<MainDataProvider>().addNewTask(
                        context.read<MainDataProvider>().taskNames[indexType],
                        taskName.text,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextModel(str:'Enter A Task Name !',textType: TextType.Title),
                          action: SnackBarAction(onPressed: (){},label:"Close",),
                        ),
                      );
                    }
                  }
                },
                color: Colors.white12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text("ADD", style: TextStyle(color: Colors.white70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
