import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier()
    : super([
        Task(title: 'お買い物', priority: 1, memo: '牛乳を買う'),
        Task(title: '仕事', priority: 2, memo: 'プロジェクトを進める'),
        Task(title: '勉強', priority: 3, isDone: true),
      ]);

  void addTask(Task task) {
    state = [...state, task];
  }

  // 完了・未完了の切り替え
  void toggleTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
            title: state[i].title,
            priority: state[i].priority,
            memo: state[i].memo,
            isDone: !state[i].isDone,
          )
        else
          state[i],
    ];
  }
}

// StateNotifierProviderに一本化
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

final undoneTaskCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(taskProvider);
  return tasks.where((task) => !task.isDone).length;
});
