import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class FirebaseAuthAPI {
  /// Creating a singleton instance of the FirebaseAuth class.
  static final FirebaseAuth auth = FirebaseAuth.instance;

  /// Creating a singleton instance of the FirebaseFirestore class.
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // /// Creating a fake instance of the FirebaseFirestore class.
  // final db = FakeFirebaseFirestore();
  // /// Creating a fake user.
  // final auth = MockFirebaseAuth(
  //     mockUser: MockUser(
  //   isAnonymous: false,
  //   uid: 'someuid',
  //   email: 'charlie@paddyspub.com',
  //   displayName: 'Charlie',
  // ));

  /// This function returns a stream of users, and the stream will emit a new user whenever the user changes.
  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  /// It takes in an email and password, and returns a string
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password of the user.
  ///
  /// Returns:
  ///   The result of the `signInWithEmailAndPassword` method is being returned.
  Future<String> signIn(String email, String password) async {
    try {
      /// Assigning the result of the `signInWithEmailAndPassword` method to the `credential` variable.
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.message!;
    } catch (e) {
      return "Unknown Error!";
    }
    return "Log-in Successful!";
  }

  /// It takes in the email, password, first name, and last name of the user and creates a new user in
  /// Firebase Authentication. If the user is successfully created, it saves the user's information to
  /// Firestore
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The user's password.
  ///   firstName (String): String
  ///   lastName (String): String
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> signUp(String email, String password, String name,
      String birthdate, String location) async {
    UserCredential credential;

    try {
      credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        saveUserToFirestore(
            credential.user?.uid, email, password, name, birthdate, location);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.message!;
    } catch (e) {
      return "Unknown Error!";
    }
    return "Sign-up Successful!";
  }

  /// It signs out the user.
  Future signOut() async {
    await auth.signOut();
  }

  Future saveUserToFirestore(String? uid, String userName, String password,
      String name, String birthdate, String location) async {
    try {
      await db.collection("users").doc(uid).set({
        "id": uid.toString(),
        "userName": userName,
        "password": password,
        "displayName": name,
        "birthDate": birthdate,
        "location": location,
        "friends": [],
        "receivedFriendRequests": [],
        "sentFriendRequest": [],
        "todoList": [],
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
