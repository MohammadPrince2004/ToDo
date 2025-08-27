import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/View/Designs/PageDesign.dart';
import 'package:todo_app/View/Designs/TaskTileDesign.dart';
import 'package:todo_app/ViewModel/MainDataProvider.dart';
import '../../Model/SelectedBorderModel.dart';
import '../Designs/TaskDeisgn.dart';
import '../Designs/TextModel.dart';
import 'TaskPage.dart';

class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<void> initFuture;

  @override
  Widget build(BuildContext context) {
    return PageDesign(
      fltAcnBt: FloatingActionButton(
        child: Icon(Icons.add_task_outlined),
        shape: CircleBorder(),
        backgroundColor: Colors.white12,
        foregroundColor: Colors.white70,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskPage(
                indexType: context.read<SelectedBorderModel>().index,
              ),
            ),
          );
        },
      ),

      tasks: Consumer<SelectedBorderModel>(
        builder: (context, model, child) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              6,
              (i) => TaskDesign(
                selected: i == model.index,
                index: i,
                taskColor: context.read<MainDataProvider>().colors[i].withAlpha(
                  25,
                ),
              ),
            ),
          );
        },
      ),
      pageType: PageType.MainPage,
      child: Consumer<SelectedBorderModel>(
        builder: (context, model, child) {
          initFuture = context.read<MainDataProvider>().createDB().then((_) {
            context.read<MainDataProvider>().getTasks(
              context.read<MainDataProvider>().taskNames[context
                  .read<SelectedBorderModel>()
                  .index],
            );
          });
          return Container(
            child: Center(
              child: FutureBuilder(
                future: initFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.white54),
                    );
                  }
                  return FutureBuilder(
                    future: context.read<MainDataProvider>().dataDB,
                    builder: (context, snapshot2) {

                      if (snapshot2.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Colors.white54));
                      }
                      if (!snapshot2.hasData || snapshot2.data!.isEmpty) {
                        return Center(child: Text("No Tasks Yet"));
                      }
                      print(snapshot2.data!);
                      return ListView.builder(
                        itemCount: snapshot2.data!.length,
                        itemBuilder: (context, i) => TaskTile(
                          taskName: snapshot2.data![i]['name'],
                          taskType: context
                              .read<MainDataProvider>()
                              .taskNames[model.index],
                        ),

                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

