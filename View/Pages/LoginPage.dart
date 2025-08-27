import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/View/Designs/PageDesign.dart';
import 'package:todo_app/View/Pages/MainPage.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool clicked;
  TextEditingController userName = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clicked = false;
  }
  @override
  Widget build(BuildContext context) {
    return PageDesign(
      pageType: PageType.LoginPage,
      // tasks:
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              backgroundColor: Colors.white12,
              radius: 75,
              child: Icon(Icons.person, size: 75.r, color: Colors.white54),
            ),
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
              child: Column(children: [Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 300.w,
              height: 70.r,
              child: TextFormField(
                keyboardType: TextInputType.name,
                onTap: (){
                  clicked = true;
                },
                validator: (value){
                  if(value==""&&clicked){
                    return "Please , Enter The Name !!";
                  }
                },
                controller: userName,
                cursorColor: Colors.white70,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(

                  label: Text(
                    "Enter The Name ",
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
              width: 150.w,
              child: MaterialButton(
                onPressed: ()async{
                  // print("context is ${userName.text}");
                  if(_formKey.currentState!.validate()){
                    if(userName.text!=""){
                      bool found = false;
                      context.read<MainDataProvider>().userName = userName.text;
                      if ((await context.read<MainDataProvider>().dataUserDB)!.length!=0){
                        (await context.read<MainDataProvider>().dataUserDB)!.forEach((v){
                          found = found|(v["name"] == userName.text);
                        });
                      }
                      if (!found){
                        context.read<MainDataProvider>().addNewUser("${userName.text}");
                      }

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
                      // print("${await context.read<MainDataProvider>().dataUserDB}");
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Enter Any Name !',style: TextStyle(color: Colors.red.shade400)),
                          action: SnackBarAction(onPressed: (){},label:"Close",),
                        ),
                      );
                    }

                  }
                },
                color: Colors.white12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                child: Text("Let's Start", style: TextStyle(color: Colors.white70)),
              ),
            ),],))
        ],
      ),
    );
  }
}
