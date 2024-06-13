import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
// reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the first time ever openning the app
  void createInitialData() {
    toDoList = [
      ['Make tutorial', false],
      ['Do Exercise', false]
    ];
  }

  // load data from database
  void LoadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the data
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
