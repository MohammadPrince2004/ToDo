import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/View/Pages/SplashScreen.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DrawerBt.dart';
import 'TextModel.dart';

class DrawerDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.black87),
          accountName: TextModel(
            str: "${context.read<MainDataProvider>().userName}",
            textType: TextType.Title,
          ),
          accountEmail: TextModel(
            str: "Perform Your Task Regularly !",
            textType: TextType.SubTitle,
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white10,
            child: Icon(Icons.person, size: 35.r, color: Colors.white70),
          ),
        ),
        DrawerBt(
          iconData: Icons.info_outline,
          txt: ' About Us ',
          onPressed: () {
            Navigator.pop(context);
            showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  height: 150.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextModel(
                        str: "About Us",
                        textType: TextType.Header,
                        color: Colors.white38,
                      ),
                      Divider(
                        indent: 70.w,
                        endIndent: 70.w,
                        color: Colors.white38,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextModel(
                              str: "Programmed By \nElprince",
                              textType: TextType.Title,
                              color: Colors.white38,
                            ),
                            SizedBox(
                              height: 70.h,
                              width: 70.w,
                              child: Image(image: AssetImage("images/mo.png")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        DrawerBt(
          iconData: Icons.call,
          txt: ' Contact Us ',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.black87,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  title: TextModel(
                    str: 'Contact Us',
                    textType: TextType.Header,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10.w),
                          TextButton(
                            style: ButtonStyle(),
                            onPressed: () async {
                              try {
                                await context
                                    .read<MainDataProvider>()
                                    .launchUrlLinkIn();
                              } catch (e) {
                                Navigator.pop(context);
                                showAboutDialog(
                                  context: context,
                                  children: [
                                    TextModel(
                                      str: "Connection Error !!",
                                      textType: TextType.Title,
                                    ),
                                  ],
                                );
                              }
                              print("Button clicked!");
                            },
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.blue,
                                  size: 20.r,
                                ),
                                SizedBox(width: 10.w),
                                TextModel(
                                  str: "On LinkedIn",
                                  textType: TextType.Title,
                                  color: Colors.white54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(child:Image(image: AssetImage("images/facebook.png"))),
                          SizedBox(width: 10.w),
                          TextButton(
                            onPressed: () async {
                              try {
                                await context
                                    .read<MainDataProvider>()
                                    .launchUrlFacebook();
                              } catch (e) {
                                Navigator.pop(context);
                                showAboutDialog(
                                  context: context,
                                  children: [
                                    TextModel(
                                      str: "Connection Error !!",
                                      textType: TextType.Title,
                                    ),
                                  ],
                                );
                              }
                              print("Button clicked!");
                            },
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.blue,
                                  size: 20.r,
                                ),
                                SizedBox(width: 10.w),
                                TextModel(
                                  str: "On Facebook",
                                  textType: TextType.Title,
                                  color: Colors.white54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: TextModel(
                        str: 'Close',
                        textType: TextType.Title,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),

        DrawerBt(
          iconData: Icons.delete_outline,
          txt: ' Clear The Database ',
          onPressed: () async {
            await context.read<MainDataProvider>().clearDatabase();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          },
        ),
      ],
    );
  }
}
