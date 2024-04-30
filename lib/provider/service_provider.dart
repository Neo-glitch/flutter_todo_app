import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/service/todo_service.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});
