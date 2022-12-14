import 'dart:convert';

class Todo {
  String userId;
  String userEmail;
  String id;
  String title;
  String? description;
  String deadline;
  bool completed;
  String lastEditBy;
  String lastEditTimeStamp;

  Todo({
    required this.userId,
    required this.userEmail,
    required this.id,
    required this.title,
    this.description,
    required this.deadline,
    required this.completed,
    required this.lastEditBy,
    required this.lastEditTimeStamp,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      userEmail: json['userEmail'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
      completed: json['completed'],
      lastEditBy: json['lastEditBy'],
      lastEditTimeStamp: json['lastEditTimeStamp'],
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      'userId': todo.userId,
      'userEmail': todo.userEmail,
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'deadline': todo.deadline,
      'completed': todo.completed,
      'lastEditBy': todo.lastEditBy,
      'lastEditTimeStamp': todo.lastEditTimeStamp,
    };
  }
}
