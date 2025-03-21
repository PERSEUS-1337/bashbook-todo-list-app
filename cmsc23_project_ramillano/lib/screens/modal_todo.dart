/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:cmsc23_project_ramillano/models/todo_model.dart';
import 'package:cmsc23_project_ramillano/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project_ramillano/assets/constants.dart' as Constants;

class TodoModal extends StatefulWidget {
  String type;
  TodoModal({
    super.key,
    required this.type,
  });

  @override
  State<TodoModal> createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  final TextEditingController _titleTextController = TextEditingController();

  final TextEditingController _descriptionTextController =
      TextEditingController();

  final TextEditingController _deadlineTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    _deadlineTextController.dispose();
    super.dispose();
  }

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle(String type) {
    switch (type) {
      case 'Add':
        return const Text("Add new todo");
      case 'Edit':
        return const Text("Edit todo");
      case 'Delete':
        return const Text("Delete todo");
      default:
        return const Text("");
    }
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context, String type) {
    // Use context.read to get the last updated list of todos
    // List<Todo> todoItems = context.read<TodoListProvider>().todo;

    switch (type) {
      case 'Delete':
        {
          return Text(
            "Are you sure you want to delete '${context.read<TodoListProvider>().selected.title}'?",
          );
        }
      // Edit and add will have input field in them
      case 'Edit':
        _titleTextController.text =
            context.read<TodoListProvider>().selected.title;
        _descriptionTextController.text =
            context.read<TodoListProvider>().selected.description!;
        _deadlineTextController.text =
            context.read<TodoListProvider>().selected.deadline;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Constants.textEditTodoTitle,
            TextFormField(
              controller: _titleTextController,
              style: Constants.textStyleWhite,
              decoration: Constants.textFormTodoTitle,
            ),
            Constants.textEditTodoDescription,
            TextFormField(
              controller: _descriptionTextController,
              style: Constants.textStyleWhite,
              decoration: Constants.textFormTodoDesc,
            ),
            Constants.textEditTodoDeadline,
            TextFormField(
              controller: _deadlineTextController,
              style: Constants.textStyleWhite,
              decoration: Constants
                  .textFormTodoDeadline, //editing controller of this TextField
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    _deadlineTextController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ],
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Constants.textEditTodoTitle,
            TextFormField(
              controller: _titleTextController,
              style: Constants.textStyleWhite,
              decoration: Constants.textFormTodoTitle,
            ),
            Constants.textEditTodoDescription,
            TextFormField(
              controller: _descriptionTextController,
              style: Constants.textStyleWhite,
              decoration: Constants.textFormTodoDesc,
            ),
            Constants.textEditTodoDeadline,
            TextFormField(
              controller: _deadlineTextController,
              style: Constants.textStyleWhite,
              decoration: Constants
                  .textFormTodoDeadline, //editing controller of this TextField
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    _deadlineTextController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ],
        );
    }
  }

  TextButton _dialogAction(BuildContext context, String type) {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm aaa').format(today);

    return TextButton(
      onPressed: () {
        switch (type) {
          case 'Add':
            {
              // Instantiate a todo objeect to be inserted, default userID will be 1, the id will be the next id in the list
              Todo temp = Todo(
                  userId: "",
                  userEmail: "",
                  completed: false,
                  title: _titleTextController.text,
                  description: _descriptionTextController.text,
                  deadline: _deadlineTextController.text,
                  id: '',
                  lastEditBy: "",
                  lastEditTimeStamp: formattedDate);
              context.read<TodoListProvider>().addTodo(temp);
              // Remove dialog after adding
              Navigator.of(context).pop();
              break;
            }
          case 'Edit':
            {
              context.read<TodoListProvider>().editTodo(
                  _titleTextController.text,
                  _descriptionTextController.text,
                  _deadlineTextController.text,
                  formattedDate);
              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
          case 'Delete':
            {
              context.read<TodoListProvider>().deleteTodo();
              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
        textStyle: Constants.textStyleWhite,
      ),
      child: Text(">>>  $type", style: Constants.textStyleGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      title: _buildTitle(widget.type),
      content: _buildContent(context, widget.type),
      backgroundColor: Colors.black87,

      // Contains two buttons - add/edit/delete, and cancel
      actions: <Widget>[
        _dialogAction(context, widget.type),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Constants.textButtonBack,
        ),
      ],
    );
  }
}
