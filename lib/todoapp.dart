import 'package:f_todoapp/provider/all_providers.dart';
import 'package:f_todoapp/widget/futureprovider.dart';
import 'package:f_todoapp/widget/title_widget.dart';
import 'package:f_todoapp/widget/todo_list_item_widget.dart';
import 'package:f_todoapp/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filterTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: const InputDecoration(
              labelText: ("Neler Yapacaksın Bugün?"),
            ),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          allTodos.isEmpty
              ? const Center(child: Text("Bu Koşulada Herhangi Bir  Görev Yok"))
              : const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ], child: const TodoListItemWidget())),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FutureProviderExample(),
                ));
              },
              child: const Text("Future Provider Example"),),
        ],
      ),
    );
  }
}
