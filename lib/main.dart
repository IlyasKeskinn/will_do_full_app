import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_do_full_app/feature/add_todos/add_task_view.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/initialize/app_start_init.dart';
import 'package:will_do_full_app/product/initialize/app_theme.dart';

void main() async {
  await AppStartInitialize.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppText.appName,
      home: const AddTaskView(),
      theme: AppTheme().theme,
    );
  }
}
