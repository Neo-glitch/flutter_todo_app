import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/common/add_task_bottomsheet.dart';
import 'package:flutter_todo_app/model/todo_model.dart';
import 'package:flutter_todo_app/provider/service_provider.dart';
import 'package:flutter_todo_app/widget/card_todo_widget.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(serviceProvider);
    var mg = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // use for the text color
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset("assets/images/profile.png"),
          ),
          title: Text(
            "Hello I'm",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade400,
            ),
          ),
          subtitle: const Text(
            "Neo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Task",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Sunday, 24 April",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(CupertinoIcons.add),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        context: context,
                        builder: (context) => AddNewTaskModel(),
                      );
                    },
                    label: const Text("New Task"),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFD5EBFA),
                      foregroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              StreamBuilder<List<TodoModel>>(
                  stream: service.getTodos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Align(
                        heightFactor: 20,
                        alignment: Alignment.center,
                        child: Text("Error fetching todos"),
                      );
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Center(
                            child: Text("Not Connected to Stream"));
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const Align(
                            heightFactor: 20,
                            alignment: Alignment.center,
                            child: Text("No Task added yet"),
                          );
                        }

                        return ListView.separated(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemBuilder: (context, index) {
                              return CardTodoListWidget(
                                  todoModel: snapshot.data![index]);
                            });
                    }
                  }),
              // Card List task
              // ListView.separated(
              //   itemCount: 3,
              //   shrinkWrap: true,
              //   separatorBuilder: (context, index) => const SizedBox(
              //     height: 10,
              //   ),
              //   itemBuilder: (context, index) {
              //     return CardTodoListWidget();
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
