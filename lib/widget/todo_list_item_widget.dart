import 'package:f_todoapp/provider/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textcontroller;
  bool _hasFocus = false;
 

  @override
  void initState() {
  
    super.initState();
    _textFocusNode = FocusNode();
    _textcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textcontroller.dispose();
   
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
          ref
              .read(todoListProvider.notifier)
              .edit(id: currentTodoItem.id, newDescription: _textcontroller.text);
        }
      },
      child: ListTile(
        onTap: (() {
          setState(() {
            _hasFocus = true;
            _textFocusNode.requestFocus();
            _textcontroller.text = currentTodoItem.description;
          });
        }),
        leading: Checkbox(
            value: currentTodoItem.completed,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: _textcontroller,
                focusNode: _textFocusNode,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
