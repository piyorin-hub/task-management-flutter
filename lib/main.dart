import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'タスク管理アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TaskListPage(),
    );
  }
}

// タスク一覧画面
class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  // 仮データ
  static final _tasks = [
    Task(title: 'お買い物', priority: 1, memo: '牛乳を買う'),
    Task(title: '仕事', priority: 2, memo: 'プロジェクトを進める'),
    Task(title: '勉強', priority: 3, isDone: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('タスク一覧')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            return TaskCard(task: task);
          },
        ),
      ),
    );
  }
}
