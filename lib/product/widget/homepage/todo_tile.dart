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
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: ColorConst.grey,
        ),
        padding: context.paddingLow,
        child: Row(
          children: [
            Checkbox(
              value: isTaskCompleted,
              onChanged: (value) {},
              shape: const CircleBorder(),
              activeColor: ColorConst.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        decoration: isTaskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 3,
                      ),
                ),
                _emptyHeightBoxLow(context),
                const _TodoTileFooter()
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _emptyHeightBoxLow(BuildContext context) =>
      SizedBox(child: context.emptySizedHeightBoxLow);
}

class _TodoTileFooter extends StatelessWidget {
  const _TodoTileFooter();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Row(
            children: [
              const _CategoryChip(),
              context.emptySizedWidthBoxLow,
              const _PriorityChip(),
            ],
          )
        ],
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorConst.priorityMedium,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        child: Icon(Icons.flag_outlined),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorConst.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        child: Row(
          children: [
            const Icon(Icons.work_outline),
            context.emptySizedWidthBoxLow,
            const Text('Work')
          ],
        ),
      ),
    );
  }
}
