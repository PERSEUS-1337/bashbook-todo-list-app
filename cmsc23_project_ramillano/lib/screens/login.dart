// import 'package:exercise7_ramillano/providers/auth_provider.dart';
// import 'package:exercise7_ramillano/screens/signup.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:cmsc23_project_ramillano/screens/signup.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:cmsc23_project_ramillano/assets/constants.dart' as Constants;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with InputValidationMixin {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    /// Creating a text field with a controller and a decoration.
    final email = TextFormField(
      key: const Key('email'),
      controller: emailController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormUserName,
      validator: ((emailController) {
        if (emailController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

    /// This is creating a text field with a controller and a decoration.
    final password = TextFormField(
      key: const Key('psWord'),
      controller: passwordController,
      obscureText: true,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormPassword,
      validator: ((passwordController) {
        if (passwordController!.isEmpty) return "This field is required";
        return null;
      }),
    );

    final loginButton = TextButton(
      key: const Key('loginButton'),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String retVal = await context.read<AuthProvider>().signIn(
              // emailController.text,
              "${emailController.text}@${emailController.text}.com",
              passwordController.text);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(retVal),
          ));
          setState(() {});
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(Constants.snackBarPressed);
      },
      child: Constants.textButtonLogin,
    );

    final signUpButton = TextButton(
      key: const Key('signUpButton'),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage()),
        );
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(Constants.snackBarPressed);
      },
      child: Constants.textButtonSignUp,
    );

    /// This is creating the layout of the login page.
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              Constants.textLoginPage,
              email,
              password,
              loginButton,
              signUpButton,
            ],
          ),
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }
}
