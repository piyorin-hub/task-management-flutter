import 'models/task.dart';

// Future は値が将来返ってくるという型
Future<List<Task>> fetchTasks() async {
  // 通信や保存の処理を想定して1秒かかるとする
  await Future.delayed(Duration(seconds: 1));
  // 仮に3つのタスクを返すとする
  return [
    Task(title: 'お買い物', priority: 1, memo: '牛乳を買う'),
    Task(title: '仕事', priority: 2, memo: 'プロジェクトを進める'),
    Task(title: '勉強', priority: 3, memo: '英語を勉強する'),
  ];
}

void main() async {
  print('タスクを取得します...');
  final tasks = await fetchTasks();
  print('タスクを取得しました: ${tasks.length}件');
  for (final task in tasks) {
    print('タスク: ${task.title}');
    print('完了: ${task.isDone}');
    print('優先度: ${task.priority}');
    print('メモ: ${task.memo}');
  }
}
