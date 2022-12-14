import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  /// It returns a stream of the user's data.
  Stream<QuerySnapshot> getMainUser() {
    print("email:\t${currentUser?.email}");
    // return db.collection('users').where('').snapshots();
    return db
        .collection('users')
        .where('id', isEqualTo: currentUser?.uid)
        .snapshots();
  }

  /// It returns a stream of all the users in the database.
  Stream<QuerySnapshot> getAllUsers() {
    // print(currentUser?.uid);
    return db
        .collection('users')
        .where('id', isNotEqualTo: currentUser?.uid)
        .snapshots();
  }

  /// It returns a stream of all the friends of the user.
  ///
  /// Args:
  ///   /// `userId` is the unique identifier of the user.
  Stream<QuerySnapshot> getAllFriends() {
    return db
        .collection('users')
        .where('friends', arrayContains: currentUser?.uid)
        .snapshots();
  }

  /// It returns a stream of all the friend requests that the user has received.
  ///
  /// Args:
  ///   userId (String): The userId of the user who is receiving the friend request.
  Stream<QuerySnapshot> getReceivedFriendRequests() {
    return db
        .collection('users')
        .where('sentFriendRequest', arrayContains: currentUser?.uid)
        .snapshots();
  }

  /// It returns a stream of all the friend requests sent by the user.
  ///
  /// Args:
  ///   userId (String): The userId of the user who sent the friend request.
  Stream<QuerySnapshot> getSentFriendRequests() {
    return db
        .collection('users')
        .where('receivedFriendRequests', arrayContains: currentUser?.uid)
        .snapshots();
  }

  /// It removes a friend from the database.
  ///
  /// Args:
  ///   userId1 (String): The userId of the user who is sending the friend request.
  ///   userId2 (String): The userId of the user you want to remove from your friend list.
  Future removeUserFriend(String userId2) async {
    await db.collection("users").doc(currentUser?.uid).update({
      "friends": FieldValue.arrayRemove([userId2])
    });

    await db.collection("users").doc(userId2).update({
      "friends": FieldValue.arrayRemove([currentUser?.uid])
    });
  }

  /// It adds the userId2 to the sentFriendRequest array of userId1 and adds userId1 to the
  /// receivedFriendRequests array of userId2
  ///
  /// Args:
  ///   userId1 (String): The user who is sending the friend request
  ///   userId2 (String): The user that is being added as a friend
  Future addUserAsFriend(String userId2) async {
    await db.collection("users").doc(currentUser?.uid).update({
      "sentFriendRequest": FieldValue.arrayUnion([userId2])
    });

    await db.collection("users").doc(userId2).update({
      "receivedFriendRequests": FieldValue.arrayUnion([currentUser?.uid])
    });
  }

  /// It accepts a friend request between two users.
  ///
  /// Args:
  ///   userId1 (String): The userId of the user who sent the friend request.
  ///   userId2 (String): The user who sent the friend request
  Future acceptFriendRequest(String userId2) async {
    await db.collection("users").doc(currentUser?.uid).update({
      "receivedFriendRequests": FieldValue.arrayRemove([userId2]),
      "friends": FieldValue.arrayUnion([userId2])
    });

    await db.collection("users").doc(userId2).update({
      "sentFriendRequest": FieldValue.arrayRemove([currentUser?.uid]),
      "friends": FieldValue.arrayUnion([currentUser?.uid])
    });
  }

  /// It rejects a friend request from userId2 to userId1.
  ///
  /// Args:
  ///   userId1 (String): The userId of the user who received the friend request.
  ///   userId2 (String): The userId of the user who sent the friend request.
  Future rejectFriendRequest(String userId2) async {
    await db.collection("users").doc(currentUser?.uid).update({
      "receivedFriendRequests": FieldValue.arrayRemove([userId2])
    });
    await db.collection("users").doc(userId2).update({
      "sentFriendRequest": FieldValue.arrayRemove([currentUser?.uid])
    });
  }
}
