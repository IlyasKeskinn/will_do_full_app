import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:will_do_full_app/feature/home/home_view.dart';
import 'package:will_do_full_app/feature/provider/category_provider.dart';
import 'package:will_do_full_app/feature/provider/priority_provider.dart';
import 'package:will_do_full_app/feature/provider/todos_provider.dart';
import 'package:will_do_full_app/feature/task_screen/sub_view/update_tasks_subview.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/widget/buttons/primary_button.dart';
import 'package:will_do_full_app/product/widget/text/subtext.dart';
import 'package:will_do_full_app/product/widget/text/subtitle_text.dart';

final _categoryProvider =
    StateNotifierProvider<CategoryProvider, CategoryState>((ref) {
  return CategoryProvider();
});

final _priorityProvider =
    StateNotifierProvider<PriorityProvider, PriorityState>((ref) {
  return PriorityProvider();
});

class TaskScreenView extends ConsumerStatefulWidget {
  const TaskScreenView({super.key, required this.todosItem});

  final Todos? todosItem;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskScreenViewState();
}

class _TaskScreenViewState extends ConsumerState<TaskScreenView> {
  @override
  void initState() {
    super.initState();
    fetchCategory();
    fetchPriority();
    setState(() {});
  }

  Future<void> fetchCategory() async {
    await Future.microtask(
      () => ref.read(_categoryProvider.notifier).fetchItems(),
    );
  }

  Future<void> fetchPriority() async {
    await Future.microtask(
      () => ref.read(_priorityProvider.notifier).fetchItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: context.paddingNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.emptySizedHeightBoxLow3x,
            TaskTitleDesc(todoItem: widget.todosItem),
            context.emptySizedHeightBoxLow,
            Padding(
              padding: context.onlyLeftPaddingMedium,
              child: SubText(
                value: widget.todosItem?.description ?? '',
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            TaskCategory(todoItem: widget.todosItem),
            context.emptySizedHeightBoxLow3x,
            TaskPriority(todoItem: widget.todosItem),
            context.emptySizedHeightBoxLow3x,
            DeleteTask(todoItem: widget.todosItem!),
            const Spacer(),
            PrimaryButton(
              value: AppText.editTask,
              click: () {
                final response = showModalBottomSheet(
                  barrierColor: ColorConst.darkgrey.withOpacity(0.9),
                  backgroundColor: ColorConst.backgrounColor,
                  isScrollControlled: true,
                  isDismissible: false,
                  context: context,
                  builder: (context) {
                    return UpdateTasksSubView(
                      todoItem: widget.todosItem,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

final _todosProvider = StateNotifierProvider<TodosProvider, TodosState>((ref) {
  return TodosProvider();
});

class DeleteTask extends ConsumerWidget {
  const DeleteTask({
    super.key,
    required this.todoItem,
  });

  final Todos todoItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.titleMedium,
        padding: const EdgeInsets.all(0),
        foregroundColor: ColorConst.error,
      ),
      onPressed: () {
        ref.watch(_todosProvider.notifier).deleteTask(todoItem);
        context.navigateToPage(const HomeView());
      },
      icon: const Icon(Icons.delete_outline),
      label: Text(AppText.deleteTask.toCapitalized()),
    );
  }
}

class TaskTitleDesc extends ConsumerStatefulWidget {
  const TaskTitleDesc({
    super.key,
    required this.todoItem,
  });
  final Todos? todoItem;

  @override
  ConsumerState<TaskTitleDesc> createState() => _TaskTitleDescState();
}

class _TaskTitleDescState extends ConsumerState<TaskTitleDesc> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.todoItem?.complete ?? false,
          onChanged: (value) {
            setState(() {
              widget.todoItem?.complete = value ?? false;
              ref.read(_todosProvider.notifier).toggleTask(widget.todoItem!);
            });
          },
          shape: const CircleBorder(),
          activeColor: ColorConst.grey,
        ),
        Expanded(
          flex: 8,
          child: SubtitleText(
            value: widget.todoItem?.title ?? 'None Title',
          ),
        ),
      ],
    );
  }
}

class TaskCategory extends StatelessWidget {
  const TaskCategory({
    required this.todoItem,
    super.key,
  });
  final Todos? todoItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(MdiIcons.tagOutline),
        Expanded(
          flex: 8,
          child: Padding(
            padding: context.onlyLeftPaddingNormal,
            child: SubtitleText(value: AppText.taskCategory.toCapitalized()),
          ),
        ),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConst.grey,
          ),
          child: Padding(
            padding:
                context.verticalPaddingNormal + context.horizontalPaddingMedium,
            child: SubtitleText(value: todoItem?.category ?? 'None Category'),
          ),
        )
      ],
    );
  }
}

class TaskPriority extends StatelessWidget {
  const TaskPriority({
    required this.todoItem,
    super.key,
  });
  final Todos? todoItem;

  @override
  Widget build(BuildContext context) {
    var priority = '';
    switch (todoItem?.priorty) {
      case 0:
        priority = 'No';
        break;
      case 1:
        priority = 'Low';
        break;
      case 2:
        priority = 'Medium';
        break;
      case 3:
        priority = 'High';
        break;
    }
    return Row(
      children: [
        const Icon(MdiIcons.flagOutline),
        Expanded(
          flex: 8,
          child: Padding(
            padding: context.onlyLeftPaddingNormal,
            child: SubtitleText(value: AppText.taskPriority.toCapitalized()),
          ),
        ),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConst.grey,
          ),
          child: Padding(
            padding:
                context.verticalPaddingNormal + context.horizontalPaddingMedium,
            child: SubtitleText(value: priority),
          ),
        )
      ],
    );
  }
}
