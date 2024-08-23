import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:intl/intl.dart';
//import '../service/work_note_service.dart';

class TodoComponent extends StatelessWidget {
  final Todo todo;
  final int index;
  final Function(int) onDelete;
  final Function(int) onToggle;

  TodoComponent({
    required this.todo,
    required this.index,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final creationTimeFormatted =
        DateFormat('yyyy-MM-dd – kk:mm').format(todo.creationTime);
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.content,
            style: TextStyle(
              decoration: todo.isComplete
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          Text(
            '新增時間: $creationTimeFormatted',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      leading: Checkbox(
        value: todo.isComplete,
        onChanged: (_) => onToggle(index),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDelete(index),
      ),
    );
  }
}
