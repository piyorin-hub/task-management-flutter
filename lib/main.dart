import 'models/task.dart';

void main() {
  final Task task = Task(
    title: 'お買い物',
    isDone: false,
    priority: 1,
    memo: '牛乳を買う',
  );
  print('タスク: ${task.title}');
  print('完了: ${task.isDone}');
  print('優先度: ${task.priority}');
  print('メモ: ${task.memo}');
}
