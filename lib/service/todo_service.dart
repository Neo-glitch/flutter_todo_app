import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/model/todo_model.dart';

class TodoService {
  // base collection or root collection
  static const String _kRootCollection = "todoApp";
  final db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>? todoCollection;

  TodoService() {
    todoCollection = db.collection(_kRootCollection);
  }

  // CREATE
  Future<DocumentReference<Map<String, dynamic>>> addNewTask(TodoModel task) {
    return todoCollection!.add(task.toMap());
  }

  // READ
  Stream<List<TodoModel>> getTodos() {
    return FirebaseFirestore.instance
        .collection(_kRootCollection)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (documentSnapshot) {
              return TodoModel.fromSnapshot(documentSnapshot);
            },
          ).toList(),
        );
  }

  // UPDATE
  void toggleTaskCheckState(String docId, bool? isChecked) {
    todoCollection!.doc(docId).update({"isDone": isChecked});
  }

  // DELETE
  void deleteTask(String docId) {
    todoCollection!.doc(docId).delete();
  }
}
