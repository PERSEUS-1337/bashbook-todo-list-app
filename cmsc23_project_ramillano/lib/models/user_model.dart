import 'dart:convert';

class User {
  // Create the different parts of the friend_model
  String id;
  String userName;
  String displayName;
  String password;
  String birthDate;
  String location;
  List? friends = [];
  List? receivedFriendRequests = [];
  List? sentFriendRequest = [];
  List? todoList = [];

  // Constructor for the friend model
  User({
    required this.id,
    required this.userName,
    required this.displayName,
    required this.password,
    required this.birthDate,
    required this.location,
    this.friends,
    this.receivedFriendRequests,
    this.sentFriendRequest,
    this.todoList,
  });

  // This returns an instance of a class that is in User format, from json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      displayName: json['displayName'],
      password: json['password'],
      birthDate: json['birthDate'],
      location: json['location'],
      friends: json['friends'],
      receivedFriendRequests: json['receivedFriendRequests'],
      sentFriendRequest: json['sentFriendRequest'],
      todoList: json['todoList'],
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  // Converts the data of User into a json that can be stored later in the firebase database
  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'userName': user.userName,
      'displayName': user.displayName,
      'password': user.password,
      'birthDate': user.birthDate,
      'location': user.location,
      'friends': user.friends,
      'receivedFriendRequests': user.receivedFriendRequests,
      'sentFriendRequest': user.sentFriendRequest,
      'todoList': user.todoList,
    };
  }
}
