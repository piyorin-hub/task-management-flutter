class Task {
  final String title;
  bool isDone;
  final int priority;
  final String? memo;

  Task({
    required this.title,
    this.isDone = false,
    required this.priority,
    this.memo,
  });
}
