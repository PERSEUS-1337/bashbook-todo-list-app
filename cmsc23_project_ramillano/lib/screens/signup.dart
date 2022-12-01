import 'package:cmsc23_project_ramillano/models/user_model.dart';
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
    TextEditingController nameController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    final userName = TextFormField(
      key: const Key('username'),
      controller: userNameController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormUserName,
      validator: ((userNameController) {
        if (userNameController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

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

    final name = TextFormField(
      key: const Key('name'),
      controller: nameController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormName,
      validator: ((nameController) {
        if (nameController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

    final birthDate = TextFormField(
      key: const Key('birthDate'),
      controller: birthDateController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormBirthDate,
      validator: ((birthDateController) {
        if (birthDateController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

    final location = TextFormField(
      key: const Key('location'),
      controller: locationController,
      style: Constants.textStyleWhite,
      decoration: Constants.textFormLocation,
      validator: ((locationController) {
        if (locationController!.isEmpty) return "This field is required.";
        return null;
      }),
    );

    final signupButton = TextButton(
      key: const Key('signupButton'),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // User temp = User(
          //   id: '', 
          //   userName: '${userNameController.text}@${userNameController.text}.com',
          //   displayName: nameController.text,
          //   password: passwordController.text, 
          //   birthDate: birthDateController.text, 
          //   location: locationController.text,
          // )
          // String retVal = await context.read<AuthProvider>().signUp(temp, 
          //   "${userNameController.text}@${userNameController.text}.com",
          //   passwordController.text
          // );
          String retVal = await context.read<AuthProvider>().signUp(
                "${userNameController.text}@${userNameController.text}.com",
                passwordController.text,
                nameController.text,
                birthDateController.text,
                locationController.text,
              );
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
              userName,
              password,
              name,
              birthDate,
              location,
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
