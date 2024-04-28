import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_app/widget/date_time_widget.dart';
import 'package:flutter_todo_app/widget/radio_widget.dart';
import 'package:flutter_todo_app/widget/textfield_widget.dart';
import 'package:flutter_todo_app/constants/app_style.dart';
import 'package:gap/gap.dart';

/**
 * Bottom sheet for adding new task
 */
class AddNewTaskModel extends StatelessWidget {
  const AddNewTaskModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  titleRadio: "LRN",
                  categoryColor: Colors.green,
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "WRK",
                  categoryColor: Colors.blue.shade700,
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "GEN",
                  categoryColor: Colors.amberAccent.shade700,
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
                valueText: "dd/mm/yy",
                iconData: CupertinoIcons.calendar,
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: "Time",
                valueText: "hh : mm",
                iconData: CupertinoIcons.time,
              ),
            ],
          ),

          // Button Section
          const Gap(12),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
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
