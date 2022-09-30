import 'package:f_todoapp/models/todo_model.dart';
import 'package:f_todoapp/provider/todolistmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilters { all, active, completed }

// ignore: non_constant_identifier_names
final TodoListFilter = StateProvider((ref) => TodoListFilters.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "Spora Git"),
    TodoModel(id: const Uuid().v4(), description: "Markete Git"),
    TodoModel(id: const Uuid().v4(), description: "Ders Çalış"),
    TodoModel(id: const Uuid().v4(), description: "Oyun Oyna"),
  ]);
}));

final filterTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(TodoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilters.all:
      return todoList;
    case TodoListFilters.completed:
      return todoList.where((element) => element.completed).toList();
    case TodoListFilters.active:
      return todoList.where((element) => !element.completed).toList();
  }
});

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>(
  (ref) {
    throw UnimplementedError();
  },
);
