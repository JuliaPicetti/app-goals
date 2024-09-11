import 'package:flutter/material.dart';
import 'package:flutter_1/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });

  final List<Widget> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3),
    Task('Trabalhar', 'assets/images/working.jpg', 5),
    Task('Cuidar de mim', 'assets/images/relaxing.jpg', 2),
    Task('Ler 30 Livros', 'assets/images/reading.jpg', 2),
    Task('Foco na Academia', 'assets/images/workout.jpg', 4),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType();
    assert(
      result != null,
    );
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
