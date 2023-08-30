import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_proje001/models/todo_model.dart';
import 'package:udemy_proje001/models/todo_model.dart';
import 'package:udemy_proje001/providers/all_providers.dart';

class TodoList extends ConsumerStatefulWidget {
  TodoList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends ConsumerState<TodoList> {
  late FocusNode _textFocusNode;
  late TextEditingController _controller;
  bool _hasFocus =
      false; //tıklanılan eleman editlemeye açık mı değil mi kontrolü
  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodoProvider);
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });

          ref.read(todoListProvider.notifier).todoGuncelle(
              id: currentTodoItem.id, newTodoName: _controller.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _textFocusNode.requestFocus();
            _controller.text = currentTodoItem.todoName;
          });
        },
        leading: Checkbox(
          value: currentTodoItem.isCompleted,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
          },
        ),
        title: _hasFocus
            ? TextField(
                controller: _controller,
                focusNode: _textFocusNode,
              )
            : Text(currentTodoItem.todoName),
      ),
    );
  }
}
