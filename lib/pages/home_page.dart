import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
// if this is the first time ever openning the app, then create the default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.LoadData();
    }

    super.initState();
  }

  // input text controller
  final _inputController = TextEditingController();

  // check box tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save the new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_inputController.text, false]);
      _inputController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            inputController: _inputController,
            onSave: saveNewTask,
            onCancel: Navigator.of(context).pop,
          );
        });
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 129, 109, 19),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Center(child: Text('TO DO')),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[300],
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) {
                checkBoxChanged(value, index);
              },
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
