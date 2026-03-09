import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

final taskProvider = StateProvider<List<Task>>((ref) {
  return [];
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

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

// Provider:TaskNotifierを外部から参照できるよにする
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
