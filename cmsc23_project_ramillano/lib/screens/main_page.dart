// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:cmsc23_project_ramillano/screens/modal_show_list.dart';
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
    Stream<QuerySnapshot> mainUserStream = context.watch<ListProvider>().mainUser;

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

          User user = User.fromJson(snapshot.data?.docs[0].data() as Map<String, dynamic>);

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
                    "> ${user.displayName};"
                  ),
                ),
                // UserName
                TextButton(
                  onPressed: () {}, 
                  child: Text(
                    style: Constants.textStyleUserName,
                    "\$ ${user.userName};"
                  ),
                ),
                // Amount of friends
                TextButton(
                  onPressed: () {}, 
                  child: Text(
                    style: Constants.textStyleWhite,
                    "\$ ls ./profile/friends | wc -l; > ${user.friends?.length};"
                  ),
                ),
                // Amount of received friend requests
                TextButton(
                  onPressed: () {}, 
                  child: Text(
                    style: Constants.textStyleWhite,
                    "\$ ls ./profile/pending_friend_requests | wc -l; > ${user.receivedFriendRequests?.length};"
                  ),
                ),
                // Amount of sent friend requests
                TextButton(
                  onPressed: () {}, 
                  child: Text(
                    style: Constants.textStyleWhite,
                    "\$ ls ./profile/sent_friend_requests | wc -l; > ${user.sentFriendRequest?.length}"
                  ),
                ),
                // Button - see users
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowListModal(type: 'user'),
                    );
                  }, 
                  child: Constants.textSeeUsers,
                ),
                // Button - see friends
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowListModal(type: 'friend',),
                    );
                  }, 
                  child: Constants.textViewFriend,
                ),
                // Button - see requests
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowListModal(type: 'request',),
                    );
                  }, 
                  child: Constants.textSeeFR,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => 
                      const Center(
                        child: Text(style: Constants.textStyleErrorCode, "> error (code 69): feature not working yet\n \$ 'tap anywhere outside the text to go back'"),)
                    );
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.mainPageAppBar,
      backgroundColor: Colors.black,
      drawer: Drawer(
          backgroundColor: Colors.black87,
          child: ListView(padding: EdgeInsets.zero, children: [
            ListTile(
              title: Constants.textButtonLogout,
              onTap: () {
                var status = context.read<AuthProvider>().signOut();
                print("Status:\t${status.}");
                Navigator.pop(context);
                // setState(() {});
              },
            ),
          ])),
      body: _buildUser(context),
    );
  }
}