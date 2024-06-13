import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final inputController;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.inputController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // get user input
              TextField(
                controller: inputController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add a new task"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(buttonTitle: 'Save', onPressed: onSave),
                  const SizedBox(
                    width: 8,
                  ),

                  // cancel button
                  MyButton(buttonTitle: 'Cancel', onPressed: onCancel),
                ],
              ),
              // buttons -> save + cancel
            ],
          )),
    );
  }
}
