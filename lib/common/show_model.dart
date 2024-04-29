import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/provider/date_time_provider.dart';
import 'package:flutter_todo_app/provider/radio_provider.dart';
import 'package:flutter_todo_app/widget/date_time_widget.dart';
import 'package:flutter_todo_app/widget/radio_widget.dart';
import 'package:flutter_todo_app/widget/textfield_widget.dart';
import 'package:flutter_todo_app/constants/app_style.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/**
 * Bottom sheet for adding new task
 */
class AddNewTaskModel extends ConsumerWidget {
  const AddNewTaskModel({
    super.key,
  });

  void showDatePickerDialog(BuildContext context, WidgetRef ref) async {
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

  void showTimePickerDialog(BuildContext context, WidgetRef ref) async {
    final result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (result != null) {
      ref.read(timeProvider.notifier).update(
            (state) => result.format(context),
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          const TextFieldWidget(
            hintText: "Add Task Name",
            maxLines: 1,
          ),
          const Gap(12),
          const Text("Description", style: AppStyle.headingOne),
          const Gap(6),
          const TextFieldWidget(hintText: "Add Decriptions", maxLines: 3),
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
                  showDatePickerDialog(context, ref);
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: "Time",
                valueText: ref.watch(timeProvider),
                iconData: CupertinoIcons.time,
                onTap: () {
                  showTimePickerDialog(context, ref);
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
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(color: Colors.blue.shade800),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Cancel"),
              )),
              Gap(20),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Create"),
              )),
            ],
          )
        ],
      ),
    );
  }
}
