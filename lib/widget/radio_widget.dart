import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget(
      {super.key,
      required this.titleRadio,
      required this.categoryColor,
      required this.valueInput,
      required this.onValueChange});

  final String titleRadio;
  final Color categoryColor;
  final int valueInput;
  final Function() onValueChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);

    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
          activeColor: categoryColor,
          contentPadding: EdgeInsets.zero,
          // transform widget is used to translate or rotate a widget
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(
              titleRadio,
              style:
                  TextStyle(color: categoryColor, fontWeight: FontWeight.w700),
            ),
          ),
          value: valueInput,
          // group value of the the radio list tile
          // when it matches the value of this, the widget is selected
          groupValue: radio,
          onChanged: (value) => onValueChange(),
        ),
      ),
    );
  }
}
