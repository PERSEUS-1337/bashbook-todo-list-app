/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:cmsc23_project_ramillano/models/todo_model.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:cmsc23_project_ramillano/providers/todo_provider.dart';
import 'package:cmsc23_project_ramillano/screens/modal_todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project_ramillano/assets/constants.dart' as Constants;

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Widget _buildDetails(BuildContext context, Todo todo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(style: Constants.textStyleWhite, "\$ todo > ${todo.title};"),
        Text(style: Constants.textStyleUserName, "\$ todoId > ${todo.id};"),
        _buildButtons(context, todo)
      ],
    );
  }

  Widget _buildButtons(BuildContext context, Todo todo) {
    return Row(
      // Only render accept and reject if it is a request list, else ignore
      children: [
        TextButton(
            onPressed: () {
              context.read<TodoListProvider>().changeSelectedTodo(todo);
              context.read<TodoListProvider>().deleteTodo();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 1),
                content: Text(
                    style: Constants.textStyleBlack,
                    'todo: ${todo.title}; deleted ... '),
              ));
            },
            child: Constants.textButtonRemove),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // access the list of todos in the provider
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
          backgroundColor: Colors.black87,
          child: ListView(padding: EdgeInsets.zero, children: [
            ListTile(
              title: Constants.textButtonLogout,
              onTap: () {
                context.read<AuthProvider>().signOut();
                Navigator.pop(context);
              },
            ),
          ])),
      appBar: Constants.todoListAppBar,
      body: StreamBuilder(
        stream: todosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Constants.snapshotError;
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Constants.snapshotWaiting;
          } else if (!snapshot.hasData) {
            return Constants.snapshotNoData;
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Todo todo = Todo.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              return InkWell(
                splashColor: Constants.splashColor,
                hoverColor: Constants.hoverColor,
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 5, bottom: 5),
                    // child: Text(
                    //     style: Constants.textStyleWhite,
                    //     "\$ todo -> ${todo.title};")),
                    child: _buildDetails(context, todo)),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => TodoModal(
              type: 'Add',
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
