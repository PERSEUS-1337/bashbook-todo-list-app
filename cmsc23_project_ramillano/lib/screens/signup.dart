import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        if (!validateStructure(passwordController!)) {
          return "Password is weak. Try a new one";
        }
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
      controller: birthDateController,
      style: Constants.textStyleWhite,
      decoration:
          Constants.textFormBirthDate, //editing controller of this TextField
      // decoration: const InputDecoration(
      //     icon: Icon(Icons.calendar_today), //icon of text field
      //     labelText: "Enter Date" //label text of field
      //     ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          // setState(() {
          birthDateController.text =
              formattedDate; //set output date to TextField value.
          // });
        } else {
          print("Date is not selected");
        }
      },
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
        setState(() {});
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

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
