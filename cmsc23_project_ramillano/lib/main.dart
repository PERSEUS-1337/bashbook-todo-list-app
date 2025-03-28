import 'package:cmsc23_project_ramillano/firebase_options.dart';
import 'package:cmsc23_project_ramillano/providers/auth_provider.dart';
import 'package:cmsc23_project_ramillano/providers/todo_provider.dart';
import 'package:cmsc23_project_ramillano/providers/user_provider.dart';
import 'package:cmsc23_project_ramillano/screens/login.dart';
import 'package:cmsc23_project_ramillano/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
        ChangeNotifierProvider(create: ((context) => ListProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleTodo',
      initialRoute: '/',
      routes: {'/': (context) => const AuthWrapper()},
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

/// > This class is a wrapper for the Auth class
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    /// Checking if the user is authenticated. If the user is authenticated, it will return the TodoPage. If not, it will return the LoginPage.
    if (context.watch<AuthProvider>().isAuthenticated) {
      // return const MainPage();
      return const MainPage();
    } else {
      return const LoginPage();
    }
  }
}