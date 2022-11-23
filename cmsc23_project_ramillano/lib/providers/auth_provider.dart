import 'package:cmsc23_project_ramillano/api/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  /// A late variable. It is a variable that is initialized after the constructor is called.
  late FirebaseAuthAPI authService;

  User? userObj;

  /// The AuthProvider() function is called when the app starts. It creates an instance of the FirebaseAuthAPI class and then calls the getUser() function.
  /// The getUser() function returns a stream of User objects.
  /// The AuthProvider() function then listens to the stream and assigns the User object to the userObj variable
  AuthProvider() {
    authService = FirebaseAuthAPI();
    authService.getUser().listen((User? newUser) {
      userObj = newUser;
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');

      /// A function that is called when the userObj variable is changed.
      /// It tells the app that the userObj variable has changed and that the app needs to rebuild the widgets that use the userObj variable.
      notifyListeners();
    }, onError: (e) {
      // provide a more useful error
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  /// A getter function that returns the userObj variable.
  User? get user => userObj;

  /// A getter function that returns a boolean value. It returns true if the userObj variable is not null.
  bool get isAuthenticated {
    return user != null;
  }

  /// It returns a Future that resolves to a String
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password of the user.
  ///
  /// Returns:
  ///   A Future object.
  Future<String> signIn(String email, String password) async {
    return await authService.signIn(email, password);
  }

  /// It signs out the user.
  void signOut() {
    authService.signOut();
  }

  /// It returns a Future that will eventually return a String
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password for the user.
  ///   firstName (String): The first name of the user.
  ///   lastName (String): The last name of the user.
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> signUp(String email, String password, String name,
      String birthdate, String location) async {
    return await authService.signUp(email, password, name, birthdate, location);
  }
}
