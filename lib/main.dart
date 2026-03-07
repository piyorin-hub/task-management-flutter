void main() {
  // List
  final List<String> tasks = ['タスク1', 'タスク2', 'タスク3'];

  print(tasks);

  tasks.add('タスク4');
  tasks.removeAt(0);
  print(tasks);

  final Map<String, bool> isDone = {'タスク2': false, 'タスク3': true, 'タスク4': false};
  print(isDone);

  isDone['タスク4'] = true;
  print(isDone);
}
