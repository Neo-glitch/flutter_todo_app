// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  // when null firebase can handle giving this a value
  String? docId;
  final String title;
  final String description;
  final String category;
  final String date;
  final String time;
  final bool isDone;

  TodoModel({
    this.docId,
    required this.isDone,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'docId': docId,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'isDone': isDone
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docId: map['docId'] != null ? map['docId'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /**
   * To get todo model from firebase firestore doc snapshot
   */
  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
        docId: doc.id,
        title: doc["title"],
        description: doc["description"],
        category: doc["category"],
        date: doc["date"],
        time: doc["time"],
        isDone: doc['isDone']);
  }
}
