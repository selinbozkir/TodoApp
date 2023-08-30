import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_proje001/models/todo_model.dart';
import 'package:udemy_proje001/providers/todolist_islemler.dart';
import 'package:uuid/uuid.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(
      id: const Uuid().v4(),
      todoName: 'Ders çalış',
    ),
    TodoModel(
      id: const Uuid().v4(),
      todoName: 'Alışverişe çık',
    ),
    TodoModel(
      id: const Uuid().v4(),
      todoName: 'Kitap oku',
    ),
  ]);
});

final unComplatedTodoCount = Provider((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.isCompleted).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});

enum TodoListFilter { all, activate, completed }

final todoListFilter = StateProvider((ref) {
  return TodoListFilter.all;
});

final filterTodos = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.completed:
      return todoList.where((element) => element.isCompleted).toList();
    case TodoListFilter.activate:
      return todoList.where((element) => !element.isCompleted).toList();
  }
});
