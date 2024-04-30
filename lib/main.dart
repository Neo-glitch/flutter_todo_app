import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/common/add_task_bottomsheet.dart';
import 'package:flutter_todo_app/firebase_options.dart';
import 'package:flutter_todo_app/view/home.dart';
import 'package:flutter_todo_app/widget/card_todo_widget.dart';
import 'package:gap/gap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(),
        home: const HomePage(),
      ),
    ),
  );
}
