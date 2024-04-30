import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/model/todo_model.dart';
import 'package:flutter_todo_app/provider/date_time_provider.dart';
import 'package:flutter_todo_app/provider/radio_provider.dart';
import 'package:flutter_todo_app/provider/service_provider.dart';
import 'package:flutter_todo_app/widget/date_time_widget.dart';
import 'package:flutter_todo_app/widget/radio_widget.dart';
import 'package:flutter_todo_app/widget/textfield_widget.dart';
import 'package:flutter_todo_app/constants/app_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/**
 * Bottom sheet for adding new task
 */
class AddNewTaskModel extends ConsumerStatefulWidget {
  const AddNewTaskModel({Key? key}) : super(key: key);

  @override
  _AddNewTaskModelState createState() => _AddNewTaskModelState();
}

class _AddNewTaskModelState extends ConsumerState<AddNewTaskModel> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;

  void showDatePickerDialog(BuildContext context) async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (result != null) {
      final format = DateFormat.yMd();
      ref.read(dateProvider.notifier).update((state) => format.format(result));
    }
  }

  void showTimePickerDialog(BuildContext context) async {
    final result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (result != null) {
      ref.read(timeProvider.notifier).update(
            (state) => result.format(context),
          );
    }
  }

  void createTask() async {
    final radioValue = ref.read(radioProvider);
    final date = ref.read(dateProvider);
    final time = ref.read(timeProvider);
    String title = titleController.text;
    String description = descriptionController.text;
    String category = "";

    switch (radioValue) {
      case 1:
        category = "Learning";
        break;
      case 2:
        category = "Working";
        break;
      case 3:
        category = "General";
        break;
    }

    if (title.isEmpty) {
      showToast("Task must have a title");
      return;
    } else if (description.isEmpty) {
      showToast("Task must have a description");
      return;
    } else if (category.isEmpty) {
      showToast("Task must have a category");
      return;
    } else if (date == "dd/mm/yy") {
      showToast("Task must have a selected start date");
      return;
    } else if (time == "hh : mm") {
      showToast("Task must have a selected start time");
      return;
    }

    updateLoadState(true);

    try {
      await ref.read(serviceProvider).addNewTask(TodoModel(
          title: title,
          description: description,
          category: category,
          date: date,
          time: time,
          isDone: false));
      showToast("Task Added Successfully");

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      showToast("Failed to add Task: ${error.toString()}");
    } finally {
      updateLoadState(false);
    }
    // Todo add a kinda loader effect to the create button and listen for complete or failed
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void updateLoadState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "New Task Todo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text("Title Task", style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            hintText: "Add Task Name",
            maxLines: 1,
            valueController: titleController,
          ),
          const Gap(12),
          const Text("Description", style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            hintText: "Add Decriptions",
            maxLines: 2,
            valueController: descriptionController,
          ),
          const Gap(12),
          const Text("Category", style: AppStyle.headingOne),
          const Gap(6),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  valueInput: 1,
                  titleRadio: "LRN",
                  categoryColor: Colors.green,
                  onValueChange: () {
                    ref.read(radioProvider.notifier).update((state) => 1);
                  },
                ),
              ),
              Expanded(
                child: RadioWidget(
                  valueInput: 2,
                  titleRadio: "WRK",
                  categoryColor: Colors.blue.shade700,
                  onValueChange: () {
                    ref.read(radioProvider.notifier).update((state) => 2);
                  },
                ),
              ),
              Expanded(
                child: RadioWidget(
                  valueInput: 3,
                  titleRadio: "GEN",
                  categoryColor: Colors.amberAccent.shade700,
                  onValueChange: () {
                    ref.read(radioProvider.notifier).update((state) => 3);
                  },
                ),
              ),
            ],
          ),
          const Gap(12),
          // Date and Time section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: "Date",
                valueText: dateProv,
                iconData: CupertinoIcons.calendar,
                onTap: () {
                  showDatePickerDialog(context);
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: "Time",
                valueText: ref.watch(timeProvider),
                iconData: CupertinoIcons.time,
                onTap: () {
                  showTimePickerDialog(context);
                },
              ),
            ],
          ),

          // Button Section
          const Gap(12),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () => isLoading ? null : Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white.withOpacity(1),
                  foregroundColor:
                      Colors.blue.shade800.withOpacity(isLoading ? .4 : 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(color: Colors.blue.shade800),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(isLoading ? "Loading..." : "Cancel"),
              )),
              Gap(20),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  isLoading ? null : createTask();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor:
                      Colors.blue.shade800.withOpacity(isLoading ? .4 : 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(isLoading ? "Loading..." : "Create"),
              )),
            ],
          )
        ],
      ),
    );
  }
}
