import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/provider/category_provider.dart';
import 'package:will_do_full_app/product/provider/priority_provider.dart';
import 'package:will_do_full_app/product/provider/todos_provider.dart';
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

class AddTaskView extends ConsumerStatefulWidget {
  const AddTaskView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends ConsumerState<AddTaskView> {
  //DateTime? _selectedDate;
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

  // Future<void> selectDate(BuildContext context) async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020, 8),
  //     lastDate: DateTime(2100, 12),
  //   );
  //   if (picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }

  Future<bool> saveTodo() async {
    final todos = Todos(
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
    return await ref.watch(_todosProvider.notifier).addTask(todos);
  }

  void updateLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
    _selectedPriorityIndex = 0;
    _selectedCategoryIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(AppText.addTask)),
      body: Stack(
        children: [
          Opacity(
            opacity: isLoading ? 0.2 : 1,
            child: IgnorePointer(
              ignoring: isLoading,
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
                      const _PriorityLevels(),
                      context.emptySizedHeightBoxLow,
                      Text(AppText.description.toCapitalized()),
                      context.emptySizedHeightBoxLow,
                      InputArea(
                        controller: descController,
                      ),
                      Text(AppText.category.toCapitalized()),
                      const CategoriesWidget(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConst.primaryColor,
                          ),
                          onPressed: titleController.text.isNullOrEmpty
                              ? null
                              : () async {
                                  updateLoading();
                                  final response = await saveTodo();
                                  updateLoading();
                                  await context.pop<bool>(response);
                                },
                          child: Text(AppText.addTask.toCapitalized()),
                        ),
                      ),
                      // Text(
                      //   _selectedDate == null
                      //       ? 'No date selected.'
                      //       : 'Selected Date: ${_selectedDate.toString()}',
                      // ),
                      // ElevatedButton(
                      //   onPressed: () => selectDate(context),
                      //   child: const Text('Select date'),
                      // ),
                    ],
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
      ),
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
  const _PriorityLevels();

  @override
  _PriorityLevelsState createState() => _PriorityLevelsState();
}

int _selectedPriorityIndex = 0;

class _PriorityLevelsState extends ConsumerState<_PriorityLevels> {
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
