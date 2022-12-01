import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project_ramillano/api/firebase_user_api.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_project_ramillano/models/user_model.dart';
import 'package:cmsc23_project_ramillano/api/user_api.dart';

class ListProvider with ChangeNotifier {
  late UserAPI userAPI;
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> _userStream;
  late Stream<QuerySnapshot> _mainUserStream;
  late Stream<QuerySnapshot> _userFriendsStream;
  late Stream<QuerySnapshot> _receivedFriendRequestsStream;
  late Stream<QuerySnapshot> _searchedFriendStream;
  User? _selectedUser;
  String userIdMain = "9T7x7PZaRdTyMP4DZE6SAKeCDwr2";

  /// It fetches the main user, all users, user friends, and received friend requests.
  ListProvider() {
    firebaseService = FirebaseUserAPI();
    fetchMainUser();
    fetchUsers();
    fetchUserFriends();
    fetchReceivedFriendRequests();
    fetchSearchedFriend();
  }

  /// Getters.
  Stream<QuerySnapshot> get users => _userStream;
  Stream<QuerySnapshot> get mainUser => _mainUserStream;
  Stream<QuerySnapshot> get userFriends => _userFriendsStream;
  Stream<QuerySnapshot> get receivedFriendRequests =>
      _receivedFriendRequestsStream;
  Stream<QuerySnapshot> get searchedFriend => _searchedFriendStream;
  User get selected => _selectedUser!;

  /// FetchUsers() -&gt; fetches all users from the database
  /// fetchMainUser() -&gt; fetches the main user from the database
  /// fetchUserFriends() -&gt; fetches all friends of the main user from the database
  /// fetchReceivedFriendRequests() -&gt; fetches all received friend requests of the main user from the database
  fetchUsers() {
    _userStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  fetchMainUser() {
    _mainUserStream = firebaseService.getMainUser();
    notifyListeners();
  }

  fetchUserFriends() {
    _userFriendsStream = firebaseService.getAllFriends(userIdMain);
    notifyListeners();
  }

  fetchReceivedFriendRequests() {
    _receivedFriendRequestsStream =
        firebaseService.getReceivedFriendRequests(userIdMain);
    notifyListeners();
  }

  fetchSearchedFriend() {
    _searchedFriendStream =
        firebaseService.getReceivedFriendRequests(userIdMain);
    notifyListeners();
  }

  /// It changes the selected user.
  ///
  /// Args:
  ///   user (User): The user that was selected.
  changeSelectedUser(User user) {
    _selectedUser = user;
  }

  /// It adds a user as a friend to another user
  ///
  /// Args:
  ///   userId1 (String): The user who is adding the friend
  ///   userId2 (String): The userId of the user you want to add as a friend
  addUserAsFriend(String userId1, String userId2) async {
    await firebaseService.addUserAsFriend(userId1, userId2);
    notifyListeners();
  }

  /// It rejects a friend request from userId1 to userId2.
  ///
  /// Args:
  ///   userId1 (String): The userId of the user who received the friend request.
  ///   userId2 (String): The userId of the user who sent the friend request.
  rejectFriendRequest(String userId1, String userId2) async {
    await firebaseService.rejectFriendRequest(userId1, userId2);
    notifyListeners();
  }

  /// It accepts a friend request from userId2 to userId1.
  ///
  /// Args:
  ///   userId1 (String): The userId of the user who received the friend request.
  ///   userId2 (String): The user who sent the friend request
  acceptFriendRequest(String userId1, String userId2) async {
    await firebaseService.acceptFriendRequest(userId1, userId2);
    notifyListeners();
  }

  /// Removes a friend from a user.
  ///
  /// Args:
  ///   userId1 (String): The userId of the user who is removing the friend.
  ///   userId2 (String): The userId of the friend you want to remove
  removeFriendFromUser(String userId1, String userId2) async {
    await firebaseService.removeUserFriend(userId1, userId2);
    notifyListeners();
  }
}
