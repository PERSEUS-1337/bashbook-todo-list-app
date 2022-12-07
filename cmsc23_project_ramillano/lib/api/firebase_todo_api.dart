import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  // final db = FakeFirebaseFirestore();

  Future<String> addTodo(Map<String, dynamic> todo) async {
    todo['userId'] = currentUser?.uid;
    try {
      final docRef = await db.collection("todos").add(todo);
      await db.collection("todos").doc(docRef.id).update({'id': docRef.id});

      await db.collection("users").doc(currentUser?.uid).update({
        'todoList': FieldValue.arrayUnion([docRef.id])
      });

      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllTodos() {
    return db.collection("todos").snapshots();
  }

  Stream<QuerySnapshot> getUserTodos() {
    return db
        .collection("todos")
        .where('userId', isEqualTo: currentUser?.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getFriendsTodos() {
    return db
        .collection("todos")
        .where('userId', isNotEqualTo: currentUser?.uid)
        .snapshots();
  }

  Future<String> deleteTodo(String? id) async {
    try {
      await db.collection("todos").doc(id).delete();
      await db.collection("users").doc(currentUser?.uid).update({
        'todoList': FieldValue.arrayRemove([id])
      });

      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
  Future<String> editTodo(String? id, String newTitle) async {
    try {
      await db.collection("todos").doc(id).update({
        'title': newTitle
      });

      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
