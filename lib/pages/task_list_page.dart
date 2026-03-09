import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import '../pages/task_detail_page.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // タスクリストを購読して、変更があったら再描画
    final tasks = ref.watch(taskProvider);
    final undoneTaskCount = ref.watch(undoneTaskCountProvider);

    return Scaffold(
      appBar: AppBar(title: Text('タスク一覧 未完了：$undoneTaskCount')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Column(
              children: [
                TaskCard(
                  task: task,
                  onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailPage(task: task),
                    ),
                  ),
                      // ref.read(taskProvider.notifier).toggleTask(index),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(taskProvider.notifier)
            .addTask(Task(title: '新しいタスク', priority: 1)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
