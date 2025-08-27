import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Model/SelectedBorderModel.dart';
import 'package:todo_app/View/Designs/TaskDeisgn.dart';
import 'package:todo_app/View/Designs/TextModel.dart';
import 'package:todo_app/View/Pages/TaskPage.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

import '../Pages/MainPage.dart';
import 'DrawerDesign.dart';

class PageDesign extends StatelessWidget {
  PageType pageType;
  Widget child;
  Widget? tasks;
  FloatingActionButton? fltAcnBt;
  // Widget taskType;

  PageDesign({
    required this.pageType,
    required this.child,
    this.tasks,
    this.fltAcnBt,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: fltAcnBt,
        drawer: pageType == PageType.MainPage
            ? Drawer(
                child: DrawerDesign(),
                backgroundColor: Colors.white12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              )
            : null,
        backgroundColor: Colors.black87,
        body: Column(
          children: [
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      child: pageType == PageType.MainPage
                          ? Builder(
                              builder: (context) {
                                return IconButton(
                                  splashColor: Colors.white54,
                                  color: Colors.white70,
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: Icon(Icons.menu),
                                );
                              },
                            )
                          : pageType == PageType.TaskPage
                          ? IconButton(
                              splashColor: Colors.white54,
                              color: Colors.white70,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            )
                          : null,
                    ),
                    TextModel(str: "To Do   App", textType: TextType.Header),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: (tasks != null) ? 200.h : 0,
              child: tasks ?? SizedBox(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(120),
                      blurRadius: 10.r,
                      spreadRadius: .1.r,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.r),
                      ),
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum PageType { MainPage, TaskPage, LoginPage }
