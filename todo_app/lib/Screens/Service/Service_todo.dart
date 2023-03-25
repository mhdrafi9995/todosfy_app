import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  //coletionreftodo

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("todos");

  //read all todo
  Stream<QuerySnapshot> todoStreem() {
    return _collectionReference.snapshots();
  }
  //add todo

  Future<DocumentReference> addTod(String title) {
    return _collectionReference.add({"title": title, "isDone": false});
  }

  //update todo by id
  Future<void> updateTodo(String id, bool isDone) {
    return _collectionReference.doc(id).update({"isDone": isDone});
  }
  //Delete todo by id

  Future<void> deleteTodo(String id) {
    return _collectionReference.doc(id).delete();
  }
}
