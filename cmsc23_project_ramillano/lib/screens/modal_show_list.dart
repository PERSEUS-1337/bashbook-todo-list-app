import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project_ramillano/models/user_model.dart';
import 'package:cmsc23_project_ramillano/providers/user_provider.dart';
import 'package:cmsc23_project_ramillano/assets/constants.dart' as Constants;

class ShowListModal extends StatefulWidget {
  String type;
  ShowListModal({super.key, required this.type});

  @override
  State<ShowListModal> createState() => _ShowListModalState();
}

class _ShowListModalState extends State<ShowListModal> {
  Widget _buildContent(BuildContext context) {
    // access the list  in the provider
    // Make users as default, change when needed
    /// Creating a stream of the data that is returned from the provider.
    Stream<QuerySnapshot> listStream = context.watch<ListProvider>().users;
    AppBar currentAppBar = Constants.requestListAppBar;
    switch (widget.type) {
      case 'user':
        listStream = context.watch<ListProvider>().users;
        currentAppBar = Constants.userListAppBar;
        break;
      case 'friend':
        listStream = context.watch<ListProvider>().userFriends;
        currentAppBar = Constants.friendListAppBar;
        break;
      case 'request':
        listStream = context.watch<ListProvider>().receivedFriendRequests;
        currentAppBar = Constants.requestListAppBar;
        break;
    }

    return Scaffold(
      appBar: currentAppBar,
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: listStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Constants.snapshotError;
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Constants.snapshotWaiting;
          } else if (!snapshot.hasData) {
            return Constants.snapshotNoData;
          }

          /// Creating a list of items from the data that is returned from the stream.
          return ListView.builder(
            shrinkWrap: true,
            itemCount: (snapshot.data?.docs
                .length), // This returns how many documents there are
            itemBuilder: ((context, index) {
              User user = User.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              return InkWell(
                splashColor: Constants.splashColor,
                hoverColor: Constants.hoverColor,
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(5),
                    child: _buildDetails(context, user)),
                // ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildDetails(BuildContext context, User user) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(style: Constants.textStyleDisplayName, "\$ id > ${user.id};"),
        // Text(
        //     style: Constants.textStyleUserName, "\$ uName > ${user.userName};"),
        Text(
            style: Constants.textStyleWhite,
            "\$ dName > ${user.displayName};"),
        Text(
            style: Constants.textStyleTeal,
            "\$ bDate > ${user.birthDate};"),
        Text(
            style: Constants.textStyleTeal,
            "\$ location > ${user.location};"),
        _buildButtons(context, user)
      ],
    );
  }

  Widget _buildButtons(BuildContext context, User user) {
    return Row(
      // Only render accept and reject if it is a request list, else ignore
      children: [
        if (widget.type == 'friend' || widget.type == 'request')
          TextButton(
              onPressed: () {
                context.read<ListProvider>().changeSelectedUser(user);
                if (widget.type == 'friend') {
                  context.read<ListProvider>().removeFriendFromUser(user.id);
                } else {
                  context.read<ListProvider>().rejectFriendRequest(user.id);
                }
              },
              child: Constants.textButtonRemove),
        if (widget.type == 'request')
          TextButton(
              onPressed: () {
                context.read<ListProvider>().changeSelectedUser(user);
                context.read<ListProvider>().acceptFriendRequest(user.id);
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowListModal(
                    type: 'request',
                  ),
                );
              },
              child: Constants.textButtonAccept),
        if (widget.type == 'user')
          TextButton(
              onPressed: () {
                context.read<ListProvider>().changeSelectedUser(user);
                context.read<ListProvider>().addUserAsFriend(user.id);
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowListModal(
                    type: 'user',
                  ),
                );
              },
              child: Constants.testButtonAddFriend),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.black,
      content: Column(
        children: [
          Flexible(
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }
}
