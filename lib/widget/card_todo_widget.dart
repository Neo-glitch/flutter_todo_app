import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/model/todo_model.dart';
import 'package:flutter_todo_app/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.todoModel,
  });

  final TodoModel todoModel;

  Color getCategoryColor() {
    switch (todoModel.category) {
      case 'Learning':
        return Colors.green;
      case 'Working':
        return Colors.blue.shade700;
      case "General":
        return Colors.amberAccent.shade700;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: getCategoryColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton(
                      onPressed: () {
                        ref.read(serviceProvider).deleteTask(todoModel.docId!);
                      },
                      icon: Icon(CupertinoIcons.delete),
                    ),
                    title: Text(
                      todoModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration: todoModel.isDone
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    subtitle: Text(
                      todoModel.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration: todoModel.isDone
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    trailing: Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        shape: const CircleBorder(),
                        value: todoModel.isDone,
                        onChanged: (value) {
                          ref
                              .read(serviceProvider)
                              .toggleTaskCheckState(todoModel.docId!, value);
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          children: [
                            Text("Today - "),
                            Text(todoModel.time),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
