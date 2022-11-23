import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project_ramillano/assets/constants.dart' as Constants;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with InputValidationMixin {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    /// Creating a text field with a controller and a decoration.
    final email = TextFormField(
      key: const Key('email'),
      controller: emailController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormEmail,
      validator: ((emailController) {
        if (isValidEmail(emailController!)) {
          return null;
        } else {
          return "Enter valid email";
        }
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

    /// This is creating a text field with a controller and a decoration.
    final firstName = TextFormField(
      key: const Key('firstName'),
      controller: firstNameController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormFirstName,
      validator: ((firstNameController) {
        if (firstNameController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

    /// This is creating a text field with a controller and a decoration.
    final lastName = TextFormField(
      key: const Key('lastName'),
      controller: lastNameController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormLastName,
      validator: ((lastNameController) {
        if (lastNameController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

    final signupButton = TextButton(
      key: const Key('signupButton'),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String retVal = await context.read<AuthProvider>().signUp(
              emailController.text,
              passwordController.text,
              firstNameController.text,
              lastNameController.text);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(retVal),
          ));
          if (retVal == "Sign-up Successful!") {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            setState(() {});
          }
        }
      },
      child: Constants.textButtonSignUp,
    );

    final backButton = TextButton(
      key: const Key('backButton'),
      onPressed: () async {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(Constants.snackBarPressed);
      },
      child: Constants.textButtonBack,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              Constants.textSignUpPage,
              email,
              password,
              firstName,
              lastName,
              signupButton,
              backButton
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
