import 'package:flutter/material.dart';
import 'package:flutter_1/data/task_inherited.dart';
import 'package:flutter_1/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: TaskInherited(child: const InitialScreen()),
    );
  }
}
