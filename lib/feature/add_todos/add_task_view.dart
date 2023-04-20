import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/constants/string_const.dart';

class AddTaskView extends ConsumerStatefulWidget {
  const AddTaskView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends ConsumerState<AddTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.addTask)),
      body: Form(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Title'),
              context.emptySizedHeightBoxLow,
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const Text('Priority'),
              context.emptySizedHeightBoxLow,
              const _PriorityLevels(),
              context.emptySizedHeightBoxLow,
              const Text('Description'),
              context.emptySizedHeightBoxLow,
              TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 6,
                maxLines: 6,
                maxLength: 250,
              ),
              const Text('Category'),
              const _Categories(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.primaryColor,
                  ),
                  onPressed: () {},
                  child: const Text('Add Task'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLow,
            child: _CategoryChip(
              categoryName: 'Sport',
              categoryColor: ColorConst.categoryColorSports,
            ),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.categoryName,
    required this.categoryColor,
  });
  final String categoryName;
  final Color categoryColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 2,
      padding: const EdgeInsets.all(14),
      label: Text(categoryName),
      labelStyle: TextStyle(color: ColorConst.white),
      backgroundColor: categoryColor,
    );
  }
}

class _PriorityLevels extends StatelessWidget {
  const _PriorityLevels();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PriorityCard(
            priorityLevel: AppText.priorityNo,
            priorityColor: ColorConst.priorityNone,
          ),
        ),
        Expanded(
          child: _PriorityCard(
            priorityColor: ColorConst.priorityLow,
            priorityLevel: AppText.priorityLow,
          ),
        ),
        Expanded(
          child: _PriorityCard(
            priorityLevel: AppText.priorityMedium,
            priorityColor: ColorConst.priorityMedium,
          ),
        ),
        Expanded(
          child: _PriorityCard(
            priorityLevel: AppText.priorityHigh,
            priorityColor: ColorConst.priorityHigh,
          ),
        ),
      ],
    );
  }
}

class _PriorityCard extends StatelessWidget {
  const _PriorityCard({
    required this.priorityColor,
    required this.priorityLevel,
  });
  final String priorityLevel;
  final Color priorityColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorConst.darkgreyTw,
      child: SizedBox(
        height: 64,
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flag_outlined,
              color: priorityColor,
            ),
            Text(
              priorityLevel,
              style: TextStyle(color: priorityColor),
            )
          ],
        ),
      ),
    );
  }
}
