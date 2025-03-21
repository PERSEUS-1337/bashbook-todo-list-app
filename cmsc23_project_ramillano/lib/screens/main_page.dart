// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:cmsc23_project_ramillano/screens/modal_show_list.dart';
import 'package:cmsc23_project_ramillano/screens/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project_ramillano/models/user_model.dart';
import 'package:cmsc23_project_ramillano/providers/user_provider.dart';
import 'package:cmsc23_project_ramillano/assets/constants.dart' as Constants;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _buildUser(BuildContext context) {
    // MainUserStream returns a stream of the main user (in this case, only 1 item) that will be used as the main user for the program in which to add, accept, reject and unfriend users
    Stream<QuerySnapshot> mainUserStream =
        context.watch<ListProvider>().mainUser;

    // Returned to the main page called
    return Scaffold(
      // StreamBuilder is used to build the updated data. This page will be updated immediately when something in the database is changed
      body: StreamBuilder(
        stream: mainUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Constants.snapshotWaiting;
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Constants.snapshotError;
          } else if (!snapshot.hasData) {
            return Constants.snapshotNoData;
          }

          User user = User.fromJson(
              snapshot.data?.docs[0].data() as Map<String, dynamic>);

          return Container(
            decoration: Constants.blackBoxDecor,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // DisplayName
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleDisplayNameMain,
                      "> ${user.displayName};"),
                ),
                // UserName
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleUserName,
                      "\$ ${user.userName};"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleYellow,
                      "\$ ls ./profile/birthdate; ${user.birthDate};"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleYellow,
                      "\$ ls ./profile/location; ${user.location};"),
                ),
                // Amount of friends
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleWhite,
                      "\$ ls ./profile/friends | wc -l; > ${user.friends?.length};"),
                ),
                // Amount of received friend requests
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleWhite,
                      "\$ ls ./profile/pending_friend_requests | wc -l; > ${user.receivedFriendRequests?.length};"),
                ),
                // Amount of sent friend requests
                TextButton(
                  onPressed: () {},
                  child: Text(
                      style: Constants.textStyleWhite,
                      "\$ ls ./profile/sent_friend_requests | wc -l; > ${user.sentFriendRequest?.length}"),
                ),
                // Button - see users
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ShowListModal(type: 'user'),
                    );
                  },
                  child: Constants.textSeeUsers,
                ),
                // Button - see friends
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowListModal(
                        type: 'friend',
                      ),
                    );
                  },
                  child: Constants.textViewFriend,
                ),
                // Button - see requests
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowListModal(
                        type: 'request',
                      ),
                    );
                  },
                  child: Constants.textSeeFR,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => const Center(
                              child: Text(
                                  style: Constants.textStyleErrorCode,
                                  "> error (code 404): feature not working yet\n \$ 'tap anywhere outside the text to go back'"),
                            ));
                  },
                  child: Constants.textSearchFriend,
                ),
              ],
            ),
          );
        },
      ),
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
            title: Constants.textButtonTodo,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoPage()),
              );
              setState(() {});
            },
          ),
          ListTile(
            title: Constants.textButtonLogout,
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.mainPageAppBar,
      backgroundColor: Colors.black,
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Flexible(
            child: _buildUser(context),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
                style: Constants.textStyleWhite,
                "\$ Please do shift+R on console if user is not updated upon login. Bug still not solveable after 1 week..."),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2.00,
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
                style: Constants.textStyleBlue,
                "\$ Made by: PERSEUS-1337;\nAron Resty Ramillano - D3L"),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2.00,
          ),
        ],
      ),
    );
  }
}
