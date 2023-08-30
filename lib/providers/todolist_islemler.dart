import 'package:udemy_proje001/models/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_proje001/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String todoName) {
    var uuid = Uuid();
    var newTodo = TodoModel(
      id: uuid.v4(),
      todoName: todoName,
    );
    state = [...state, newTodo];
  }

  //checkbox için tıklanmışsa tıklanmamışa, tıklanmamışsa tıklanmışa geliyor
  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            todoName: todo.todoName,
            isCompleted: !todo.isCompleted,
          )
        else
          todo
    ];
  }

  void todoGuncelle({required id, required newTodoName}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            todoName: newTodoName,
            isCompleted: todo.isCompleted,
          )
        else
          todo
    ];
  }

  void todoSil({required id}) {
    state = state.where((e) => e.id != id).toList();
  }

  int tamamlananGorevSayisi() {
    return state.where((e) => e.isCompleted).length;
  }
}
