class TodoModel {
  String id;
  String todoName;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.todoName,
    this.isCompleted = false,
  });
}
