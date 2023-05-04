import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/feature/task_screen/task_screen_view.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/widget/homepage/todo_tile.dart';

class HomeSearchDelegate extends SearchDelegate<Todos?> {
  HomeSearchDelegate({required this.todoItems});
  final List<Todos> todoItems;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.delete_outline),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.chevron_left),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = todoItems.where(
      (element) =>
          element.title?.toLowerCase().contains(query.toLowerCase()) ?? false,
    );

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: context.paddingLow,
          child: ToDoTileWidget(
            todoItem: result.elementAt(index),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = todoItems.where(
      (element) =>
          element.title?.toLowerCase().contains(query.toLowerCase()) ?? false,
    );

    return Padding(
      padding: context.verticalPaddingNormal,
      child: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLow,
            child: InkWell(
              onTap: () {
                context.navigateToPage(
                  TaskScreenView(todosItem: result.elementAt(index)),
                  type: SlideType.TOP,
                );
              },
              child: ToDoTileWidget(todoItem: result.elementAt(index)),
            ),
          );
        },
      ),
    );
  }
}
