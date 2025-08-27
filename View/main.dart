import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Model/SelectedBorderModel.dart';
import 'package:todo_app/View/Pages/SplashScreen.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

import 'Pages/LoginPage.dart';
import 'Pages/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (_,child) {
        return MultiProvider(
          providers: [Provider<MainDataProvider>(create: (context)=>MainDataProvider())],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => SelectedBorderModel()),
            ],
            child: MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false),
          ),
        );
      }
    );
  }
}
