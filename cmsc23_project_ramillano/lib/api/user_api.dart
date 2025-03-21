import 'dart:async';
import 'package:cmsc23_project_ramillano/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  Future<List<User>> fetchUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      return User.fromJsonArray(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}