import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';

// ignore: must_be_immutable
class ToDoTileWidget extends StatelessWidget {
  const ToDoTileWidget({
    super.key,
    required this.taskName,
    required this.isTaskCompleted,
  });
  final String taskName;
  final bool isTaskCompleted;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onPressed: (context) {},
            icon: Icons.delete,
            backgroundColor: ColorConst.primaryColor,
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: ColorConst.grey,
        ),
        padding: context.paddingLow,
        child: Row(
          children: [
            Transform.scale(
              scale: 1,
              child: Checkbox(
                value: isTaskCompleted,
                onChanged: (value) {},
                shape: const CircleBorder(),
                activeColor: ColorConst.grey,
              ),
            ),
            Text(
              taskName,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    decoration: isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 3,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
