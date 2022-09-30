import 'package:f_todoapp/provider/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({super.key});
  var _currentFilter = TodoListFilters.all;

  Color changeTextColor(TodoListFilters filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(TodoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            onCompletedTodoCount == 0
                ? "Tüm GÖrevler Yapıldı"
                : "$onCompletedTodoCount Görev Tamamlanmadı",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: "All Todos",
          child: TextButton(style:TextButton.styleFrom(primary: changeTextColor(TodoListFilters.all)) ,
            onPressed: () {
              ref.read(TodoListFilter.notifier).state = TodoListFilters.all;
            },
            child: const Text("All"),
          ),
        ),
        Tooltip(
          message: "Only Uncomleted Todos",
          child: TextButton(style:TextButton.styleFrom(primary: changeTextColor(TodoListFilters.active)),
            onPressed: () {
              ref.read(TodoListFilter.notifier).state = TodoListFilters.active;
            },
            child: const Text("Active"),
          ),
        ),
        Tooltip(
          message: "Only Comleted Todos",
          child: TextButton(style:TextButton.styleFrom(primary: changeTextColor(TodoListFilters.completed)),
            onPressed: () {
              ref.read(TodoListFilter.notifier).state =
                  TodoListFilters.completed;
            },
            child: const Text("Completed"),
          ),
        ),
      ],
    );
  }
}
