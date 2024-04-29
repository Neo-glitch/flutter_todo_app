import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTodoListWidget extends StatelessWidget {
  const CardTodoListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              color: Colors.red,
              borderRadius: BorderRadius.only(
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
                    title: Text("Leading Flutter Developer"),
                    subtitle: Text("Learning about riverpod and Bloc"),
                    trailing: Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        shape: const CircleBorder(),
                        value: true,
                        onChanged: (value) {},
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
                            Text("09:15PM - 11:45PM"),
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
