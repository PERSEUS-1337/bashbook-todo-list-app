import 'package:flutter/material.dart';

const mainUserId = "9mxC9IiSmA5KOlwzHzeI";

// Colors and Values
const userNameColorAccent = Colors.lightBlueAccent;
const displayNameColorAccent = Colors.deepPurpleAccent;
const semiBlackColor = Color.fromARGB(255, 19, 19, 19);
const neonBlurRadiusMain = 10.0;
const neonBlurRadiusBox = 2.0;
const neonBlurRadius = 5.0;

// Decorations
const blackBoxDecor = BoxDecoration(color: Colors.black);

// InkWell colors
const splashColor = Colors.blueGrey;
const hoverColor = Color.fromARGB(255, 0, 0, 0);

/// A constant variable that is used to style the app bar.
AppBar mainPageAppBar = AppBar(
  backgroundColor: Colors.lightGreenAccent,
  title: const Text(style: textStyleAppBar, "\$ <bash_book\>™;"),
);
AppBar userListAppBar = AppBar(
  iconTheme: const IconThemeData(
      color: Colors.white, shadows: appBarShadow //change your color here
      ),
  backgroundColor: Colors.black,
  title: const Text(style: textStyleWhite, "\$ ./users;"),
);
AppBar friendListAppBar = AppBar(
  iconTheme: const IconThemeData(color: Colors.white, shadows: appBarShadow),
  backgroundColor: Colors.black,
  title: const Text(style: textStyleWhite, "\$ ./profile/friends;"),
);
AppBar requestListAppBar = AppBar(
  iconTheme: const IconThemeData(color: Colors.white, shadows: appBarShadow),
  backgroundColor: Colors.black,
  title: const Text(style: textStyleWhite, "\$ ./friend_requests;"),
);
AppBar todoListAppBar = AppBar(
  iconTheme: const IconThemeData(color: Colors.white, shadows: appBarShadow),
  backgroundColor: Colors.black,
  title: const Text(style: textStyleWhite, "\$ ./screen/todo_page;"),
);

const appBarShadow = <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0), blurRadius: neonBlurRadius, color: Colors.white)
];


/// A constant variable that is used to style text.
// Specific Text Styles for Specific Texts
const textStyleDisplayNameMain =
    TextStyle(color: displayNameColorAccent, fontSize: 50, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadiusMain,
      color: displayNameColorAccent)
]);
const textStyleDisplayName =
    TextStyle(color: displayNameColorAccent, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadius,
      color: displayNameColorAccent)
]);
const textStyleUserName =
    TextStyle(color: userNameColorAccent, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadius,
      color: userNameColorAccent)
]);
const textStyleAppBar = TextStyle(color: Colors.black, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadiusMain,
      color: Colors.black)
]);
const textStyleErrorCode =
    TextStyle(color: Colors.redAccent, fontSize: 20, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadiusMain,
      color: Colors.redAccent)
]);
const textStyleLoginPage =
    TextStyle(color: Colors.redAccent, fontSize: 50, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadiusMain,
      color: Colors.redAccent)
]);
const textStyleSignUpPage =
    TextStyle(color: Colors.greenAccent, fontSize: 50, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadiusMain,
      color: Colors.greenAccent)
]);

// Generic Colored Text Styles
const textStyleWhite = TextStyle(color: Colors.white, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0), blurRadius: neonBlurRadius, color: Colors.white)
]);
const textStyleTeal = TextStyle(color: Colors.tealAccent, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0), blurRadius: neonBlurRadius, color: Colors.white)
]);
const textStyleRed = TextStyle(color: Colors.redAccent, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadius,
      color: Colors.redAccent)
]);
const textStyleGreen = TextStyle(color: Colors.greenAccent, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadius,
      color: Colors.greenAccent)
]);
const textStyleOrange = TextStyle(color: Colors.orangeAccent, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: neonBlurRadius,
      color: Colors.greenAccent)
]);
const textStyleBlack = TextStyle(color: Colors.black, shadows: <Shadow>[
  Shadow(
      offset: Offset(0.0, 0.0), blurRadius: neonBlurRadius, color: Colors.black)
]);

// TextStyle w/ text, used for buttons
const textLoginPage = Text(style: textStyleLoginPage, "\$ ./screen/login ...");
const textSignUpPage =
    Text(style: textStyleSignUpPage, "\$ ./screen/signup ...");

const textSeeUsers = Text(style: textStyleTeal, "\$ Press to see ./users ...");
const textAddFriend =
    Text(style: textStyleTeal, "\$ Press to add ./profile/friends ...");
const textViewFriend =
    Text(style: textStyleTeal, "\$ Press to view ./profile/friends ...");
const textSeeFR =
    Text(style: textStyleTeal, "\$ Press to see ./profile/friend_requests ...");
const textSearchFriend =
    Text(style: textStyleTeal, "\$ Press to search for \${user.friend} ...");

const textButtonRemove = Text(style: textStyleRed, ">>> Remove");
const textButtonAccept = Text(style: textStyleGreen, ">>> Accept");
const textButtonAdd = Text(style: textStyleOrange, ">>> Add friend");
const textButtonLogin = Text(style: textStyleRed, ">>> Login");
const textButtonLogout = Text(style: textStyleRed, ">>> Logout");
const textButtonSignUp = Text(style: textStyleGreen, ">>> Sign Up");
const textButtonBack = Text(style: textStyleRed, ">>> Back");

const textFormEmail =
    InputDecoration(hintText: "Email", hintStyle: textStyleWhite);
const textFormPassword =
    InputDecoration(hintText: "Password", hintStyle: textStyleWhite);
const textFormFirstName =
    InputDecoration(hintText: "First Name", hintStyle: textStyleWhite);
const textFormLastName =
    InputDecoration(hintText: "Last Name", hintStyle: textStyleWhite);
const textFormName =
    InputDecoration(hintText: "Name", hintStyle: textStyleWhite);
const textFormBirthDate =
    InputDecoration(hintText: "Birth Date", hintStyle: textStyleWhite);
const textFormLocation =
    InputDecoration(hintText: "Location", hintStyle: textStyleWhite);
const textFormUserName =
    InputDecoration(hintText: "User Name", hintStyle: textStyleWhite);
    
// StreamBuilder errors
const snapshotWaiting = Center(child: CircularProgressIndicator());
const snapshotError = Center(child: CircularProgressIndicator());
const snapshotNoData = Center(child: CircularProgressIndicator());

const textPressed = Text(style: textStyleBlack, "\$ Pressed;");
SnackBar snackBarPressed = const SnackBar(
  backgroundColor: Colors.white,
  duration: Duration(milliseconds: 500),
  content: textPressed,
);