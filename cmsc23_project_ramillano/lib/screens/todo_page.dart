/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:cmsc23_project_ramillano/models/todo_model.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:cmsc23_project_ramillano/providers/todo_provider.dart';
import 'package:cmsc23_project_ramillano/screens/login.dart';
import 'package:cmsc23_project_ramillano/screens/main_page.dart';
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
        // Text(style: Constants.textStyleUserName, "\$ todoId > ${todo.id};"),
        Text(
            style: Constants.textStyleUserName,
            "\$ todoUserId > ${todo.userId};"),
        _buildButtons(context, todo)
      ],
    );
  }

  Widget _buildButtons(BuildContext context, Todo todo) {
    return Row(
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
        TextButton(
            onPressed: () {
              context.read<TodoListProvider>().changeSelectedTodo(todo);
              showDialog(
                context: context,
                builder: (BuildContext context) => TodoModal(
                  type: 'Edit',
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 1),
                content: Text(
                    style: Constants.textStyleBlack,
                    'todo: ${todo.title}; edited ... '),
              ));
            },
            child: Constants.textButtonEdit),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: Constants.textButtonUserProfile,
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
              setState(() {});
            },
          ),
          ListTile(
            title: Constants.textButtonLogout,
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _todosStreamBuild(
      BuildContext context, Stream<QuerySnapshot<Object?>> todosStream) {
    return StreamBuilder(
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
    );
  }

  Widget _userTodosStream(
      BuildContext context, Stream<QuerySnapshot<Object?>> userTodosStream) {
    return StreamBuilder(
      stream: userTodosStream,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // access the list of todos in the provider
    Stream<QuerySnapshot> friendsTodosStream =
        context.watch<TodoListProvider>().friendsTodos;
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;
    Stream<QuerySnapshot> userTodosStream =
        context.watch<TodoListProvider>().userTodos;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildDrawer(context),
      appBar: Constants.todoListAppBar,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.textTodosUser,
            Flexible(child: _userTodosStream(context, userTodosStream)),
            Constants.textTodosAll,
            Flexible(child: _todosStreamBuild(context, friendsTodosStream))
          ],
        ),
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
