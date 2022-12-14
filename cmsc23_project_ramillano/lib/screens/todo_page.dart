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
  Widget _buildDetails(BuildContext context, Todo todo, String type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.white,
          thickness: 2.00,
        ),
        Text(style: Constants.textStyleWhite, "\$ todoTitle > ${todo.title};"),
        Constants.sizedBoxDivider,
        Text(
            style: Constants.textStyleWhite,
            "\$ todoDesc > ${todo.description};"),
        Constants.sizedBoxDivider,
        Text(
            style: Constants.textStyleRed,
            "\$ todoDeadline > ${todo.deadline};"),
        Constants.sizedBoxDivider,
        Text(
            style: Constants.textStyleGreen,
            "\$ todoCompleted > ${todo.completed};"),
        Constants.sizedBoxDivider,
        Text(
            style: Constants.textStyleUserName,
            "\$ todoOwner > ${todo.userEmail};"),
        Constants.sizedBoxDivider,
        Text(
            style: Constants.textStyleOrange,
            "\$ lastEditBy > ${todo.lastEditBy};"),
        Constants.sizedBoxDivider,
        Text(
            style: Constants.textStyleOrange,
            "\$ lastEditTimeStamp > ${todo.lastEditTimeStamp};"),
        _buildButtons(context, todo, type)
      ],
    );
  }

  Widget _buildButtons(BuildContext context, Todo todo, String type) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            if (type == 'user') {
              context.read<TodoListProvider>().changeSelectedTodo(todo);
              context.read<TodoListProvider>().deleteTodo();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 1),
                content: Text(
                    style: Constants.textStyleBlack,
                    'todo: ${todo.title}; deleted ... '),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 1),
                content: Text(
                    style: Constants.textStyleBlack,
                    'cannot delete: ${todo.title}; not an owner of todo ... '),
              ));
            }
          },
          child: Constants.textButtonRemove,
        ),
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
          child: Constants.textButtonEdit,
        ),

        /// A button that toggles the todo.
        TextButton(
          onPressed: () {
            /// Checking if the user is the owner of the todo.
            if (type == 'user') {
              context.read<TodoListProvider>().changeSelectedTodo(todo);
              context.read<TodoListProvider>().toggleTodo();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 1),
                content: Text(
                    style: Constants.textStyleBlack,
                    'todo: ${todo.title}; toggled ... '),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 1),
                content: Text(
                    style: Constants.textStyleBlack,
                    'cannot toggle: ${todo.title}; not an owner of todo ... '),
              ));
            }
          },
          child: Constants.textButtonStatus,
        ),
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
              setState(() {});
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Constants.textButtonLogout,
            onTap: () {
              Navigator.pop(context);
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _todosStreamBuild(BuildContext context,
      Stream<QuerySnapshot<Object?>> todosStream, String type) {
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
                      left: 10, right: 10, top: 5, bottom: 5),
                  // child: Text(
                  //     style: Constants.textStyleWhite,
                  //     "\$ todo -> ${todo.title};")),
                  child: _buildDetails(context, todo, type)),
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
    Stream<QuerySnapshot> userTodosStream =
        context.watch<TodoListProvider>().userTodos;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildDrawer(context),
      appBar: Constants.todoListAppBar,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.textTodosUser,
            Flexible(
                child: _todosStreamBuild(context, userTodosStream, 'user')),
            Constants.textTodosAll,
            Flexible(
                child:
                    _todosStreamBuild(context, friendsTodosStream, 'friends'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => TodoModal(
              type: 'Add',
            ),
          );
        },
        child: const Icon(
          Icons.add_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
