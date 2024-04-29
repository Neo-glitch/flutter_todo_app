import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/constants/app_style.dart';
import 'package:gap/gap.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget(
      {super.key,
      required this.titleText,
      required this.valueText,
      required this.iconData,
      required this.onTap});

  final String titleText;
  final String valueText;
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText, style: AppStyle.headingOne),
          Gap(6),
          // n.b Could have just used InkWell
          // but we want more customization on splash anim on tap
          Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => onTap(),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(iconData),
                      Gap(12),
                      Text(valueText),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
