import 'package:cmsc23_project_ramillano/api/firebase_todo_api.dart';
import 'package:cmsc23_project_ramillano/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;
  late Stream<QuerySnapshot> _userTodosStream;
  late Stream<QuerySnapshot> _friendsTodosStream;
  Todo? _selectedTodo;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
    fetchUserTodos();
    fetchFriendsTodos();
  }

  // getter
  Stream<QuerySnapshot> get todos => _todosStream;
  Stream<QuerySnapshot> get userTodos => _userTodosStream;
  Stream<QuerySnapshot> get friendsTodos => _friendsTodosStream;
  Todo get selected => _selectedTodo!;

  changeSelectedTodo(Todo item) {
    _selectedTodo = item;
  }

  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  void fetchUserTodos() {
    _userTodosStream = firebaseService.getUserTodos();
    notifyListeners();
  }

  void fetchFriendsTodos() {
    _friendsTodosStream = firebaseService.getFriendsTodos();
    notifyListeners();
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print("Add: $message");
    notifyListeners();
  }

  void editTodo(String newTitle, String newDesc, String newDeadline, String formattedDate) async {
    String message = await firebaseService.editTodo(_selectedTodo!.id, newTitle, newDesc, newDeadline, formattedDate);
    print("Edit: $message");
    notifyListeners();
  }

  void deleteTodo() async {
    String message = await firebaseService.deleteTodo(_selectedTodo!.id);
    print("Delete: $message");
    notifyListeners();
  }

  // void toggleStatus(int index, bool status) {
  //   // _todoList[index].completed = status;
  //   print("Toggle Status");
  //   notifyListeners();
  // }

  Future<void> toggleTodo() async {
    String message = await firebaseService.toggleTodo(_selectedTodo!.id, _selectedTodo!.completed);
    print("Toggled: $message");
    notifyListeners();
  }
}
