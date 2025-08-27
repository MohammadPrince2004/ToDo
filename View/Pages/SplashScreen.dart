import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/View/Designs/PageDesign.dart';
import 'package:todo_app/View/Pages/LoginPage.dart';
import 'package:todo_app/View/Pages/MainPage.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {

    await context.read<MainDataProvider>().createDB().then((_) {
      context.read<MainDataProvider>().getUsers();
    });
    List users = await context.read<MainDataProvider>().dataUserDB!;

    if (users.length!=0){
      context.read<MainDataProvider>().userName = users[users.length-1]["name"];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainPage()),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageDesign(
        pageType: PageType.LoginPage,
        child: Center(child: CircularProgressIndicator(color: Colors.white54)),
      ),
    );
  }
}
