import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDataProvider {
  final Uri url_linkin = Uri.parse("https://www.linkedin.com/in/eng-mohammad-elprince-a62b4b314/");
  final Uri url_facebook = Uri.parse('https://www.facebook.com/mw.alhaj.483754');
  late Database db;
  String userName = "";
  Future<List<Map>>?  dataDB;
  Future<List<Map>>?  dataUserDB;
  List<Color> colors = [
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.deepPurple,
    Colors.blue,
    Colors.lightBlue,
  ];
  List<IconData> taskIcons = [
    Icons.work_outline,
    Icons.person_outline_outlined,
    Icons.book_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.shopping_cart_outlined,
    Icons.fitness_center_outlined,
  ];
  List<String> taskNames = [
    "Work",
    "Personal",
    "Educational",
    "Financial",
    "Shopping",
    "Fitness",
  ];

  Future<void> launchUrlFacebook() async {
    if (!await launchUrl(url_facebook, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url_facebook');
    }
  }

  Future<void> launchUrlLinkIn() async {
    if (!await launchUrl(url_linkin, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url_linkin');
    }
  }
  Future<void> createDB()async{
    db = await openDatabase("Tasks.db");
    await db.execute(
        'CREATE TABLE IF NOT EXISTS Tasks (type Text, name TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS Users (name Text)');
    print("Created");
  }

  void addNewTask(String taskType,String taskName)async{
    await db.rawInsert(
        'INSERT INTO Tasks(type, name) VALUES("$taskType", "$taskName")');
    print("Added");
  }
  void addNewUser(String userName)async{

    print("ADDDDD");
    await db.rawInsert(
      'INSERT INTO Users(name) VALUES(?)',
      [userName]);
    print("Added");
  }

  Future<void> getTasks(String taskType) async {
    dataDB = db.rawQuery('SELECT * FROM Tasks WHERE type = ?', [taskType]);
    print("Got tasks for $taskType");
  }

  Future<void> getUsers() async {
    dataUserDB = db.rawQuery('SELECT * FROM Users');

  }

  Future<void> deleteTasks(String taskName)async{
      print("Deleted");

      await db
          .rawDelete('DELETE FROM Tasks WHERE name = ?', [taskName]);
  }
  Future<void> clearDatabase()async{
    await db.delete('Users');
    await db.delete('Tasks');
  }

}
