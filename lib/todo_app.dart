import 'package:flutter/material.dart';
import 'package:udemy_proje001/takvim.dart';
import 'package:udemy_proje001/widgets/title_widget.dart';
import 'package:udemy_proje001/widgets/toolbar.dart';

class TodoApp extends StatelessWidget {
  TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          const TitleWidget(),
          TakvimSayfasi(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
