import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/feature/home/home_view.dart';
import 'package:will_do_full_app/product/provider/category_provider.dart';
import 'package:will_do_full_app/product/provider/priority_provider.dart';
import 'package:will_do_full_app/product/provider/todos_provider.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/widget/buttons/primary_button.dart';
import 'package:will_do_full_app/product/widget/chips/category_chip.dart';
import 'package:will_do_full_app/product/widget/chips/priority_chip.dart';
import 'package:will_do_full_app/product/widget/text_field/text_area.dart';
import 'package:will_do_full_app/product/widget/text_field/text_input_field.dart';

final _categoryProvider =
    StateNotifierProvider<CategoryProvider, CategoryState>((ref) {
  return CategoryProvider();
});

final _priorityProvider =
    StateNotifierProvider<PriorityProvider, PriorityState>((ref) {
  return PriorityProvider();
});



class UpdateTasksSubView extends ConsumerStatefulWidget {
  const UpdateTasksSubView({
    super.key,
    required this.todoItem,
  });
  final Todos? todoItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateTasksSubViewState();
}

class _UpdateTasksSubViewState extends ConsumerState<UpdateTasksSubView> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isLoading = false;

  final _todosProvider =
      StateNotifierProvider<TodosProvider, TodosState>((ref) {
    return TodosProvider();
  });

  @override
  void initState() {
    super.initState();
    fetchCategory();
    fetchPriority();
    titleController.text = widget.todoItem?.title ?? '';
    descController.text = widget.todoItem?.description ?? '';
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

  void updateLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<bool> updateTask() async {
    final todos = Todos(
      id: widget.todoItem?.id,
      title: titleController.text,
      description: descController.text,
      complete: false,
      priorty: ref
          .watch(_priorityProvider.notifier)
          .priorities[_selectedPriorityIndex]
          .priorityLevel,
      category: ref
          .watch(_categoryProvider.notifier)
          .categories[_selectedCategoryIndex]
          .name,
      categoryColor: ref
          .watch(_categoryProvider.notifier)
          .categories[_selectedCategoryIndex]
          .categoryColor,
    );
    return await ref.watch(_todosProvider.notifier).updateTask(todos);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: isLoading ? 0.2 : 1,
          child: IgnorePointer(
            ignoring: isLoading,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: context.paddingNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppText.addTaskTitle.toCapitalized()),
                      context.emptySizedHeightBoxLow,
                      TextInputField(
                        controller: titleController,
                        hintValue: AppText.addTaskTitle.toCapitalized(),
                      ),
                      Text(AppText.priority.toCapitalized()),
                      context.emptySizedHeightBoxLow,
                      _PriorityLevels(
                        priorityLevel: widget.todoItem?.priorty ?? 0,
                      ),
                      context.emptySizedHeightBoxLow,
                      Text(AppText.description.toCapitalized()),
                      context.emptySizedHeightBoxLow,
                      InputArea(controller: descController),
                      Text(AppText.category.toCapitalized()),
                      const CategoriesWidget(),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(AppText.cancel.toCapitalized()),
                            ),
                          ),
                          context.emptySizedWidthBoxNormal,
                          Expanded(
                            child: PrimaryButton(
                              value: AppText.save.toCapitalized(),
                              click: () async {
                                updateLoading();
                                final response = await updateTask();
                                updateLoading();
                                await context.navigateToPage(const HomeView());
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}

int _selectedCategoryIndex = 0;

class CategoriesWidget extends ConsumerStatefulWidget {
  const CategoriesWidget({super.key});
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends ConsumerState<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(_categoryProvider).category;

    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLow,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: CategoryChip(
                categoryItems: category?[index],
                isSelected: _selectedCategoryIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PriorityLevels extends ConsumerStatefulWidget {
  const _PriorityLevels({required this.priorityLevel});
  final int priorityLevel;

  @override
  _PriorityLevelsState createState() => _PriorityLevelsState();
}

int _selectedPriorityIndex = 0;

class _PriorityLevelsState extends ConsumerState<_PriorityLevels> {
  @override
  void initState() {
    super.initState();
    _selectedPriorityIndex = widget.priorityLevel;
  }

  @override
  Widget build(BuildContext context) {
    final priority = ref.watch(_priorityProvider).priority;

    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: priority?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLow,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPriorityIndex = index;
                });
              },
              child: PriorityChip(
                priorityItem: priority?[index],
                isSelected: _selectedPriorityIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}
