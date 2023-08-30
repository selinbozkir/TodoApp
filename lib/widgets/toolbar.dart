import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_proje001/widgets/todo_item.dart';
import '../models/todo_model.dart';
import '../providers/all_providers.dart';

class ToolBar extends ConsumerWidget {
  final DateTime selectedDate;

  ToolBar({
    super.key,
    required this.selectedDate,
  });
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filterTodos);
    final filter = ref.watch(todoListFilter);
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Tarih: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Suranna',
                          fontSize: 20,
                          color: Color.fromARGB(255, 227, 130, 33),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const Text(
                'Yapılacaklar Listesi',
                style: TextStyle(
                  fontFamily: 'BowlbyOneSC',
                  fontSize: 20,
                  color: Colors.lime,
                ),
              ),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'BowlbyOneSC',
                    fontSize: 20,
                    color: Colors.lime,
                  ),
                  alignLabelWithHint: true,
                ),
                onSubmitted: (newTodo) {
                  if (newTodo.trim().isNotEmpty) {
                    ref.watch(todoListProvider.notifier).addTodo(newTodo);
                    textController.clear();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Uyarı'),
                          content: const Text('Lütfen yeni bir görev girin.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '  Görev Sayısı: ${ref.watch(todoListProvider).length.toString()}',
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(),
                  Tooltip(
                    message: 'Tüm Yapılacaklar',
                    child: TextButton(
                        onPressed: () {
                          ref.read(todoListFilter.notifier).state =
                              TodoListFilter.all;
                        },
                        child: const Text('Hepsi')),
                  ),
                  Tooltip(
                    message: 'Henüz Tamamlanmamış Olanlar',
                    child: TextButton(
                        onPressed: () {
                          ref.read(todoListFilter.notifier).state =
                              TodoListFilter.activate;
                        },
                        child: const Text('Devam Eden')),
                  ),
                  Tooltip(
                    message: 'Tamamlanmış Olanlar',
                    child: TextButton(
                        onPressed: () {
                          ref.read(todoListFilter.notifier).state =
                              TodoListFilter.completed;
                        },
                        child: const Text('Tamamlandı')),
                  ),
                ],
              ),
            ],
          ),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (direction) {
                ref.read(todoListProvider.notifier).todoSil(id: allTodos[i].id);
              },
              background: Container(
                color: Colors.pink,
              ),
              child: ProviderScope(overrides: [
                currentTodoProvider.overrideWithValue(
                    allTodos[i]) //currentTodo'yu bunlar güncelle diyo
              ], child: TodoList()),
            ),
          IconButton(
            onPressed: () {
              Navigator.canPop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
        ],
      ),
    );
  }
}
