import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/model/todos.dart';

// ignore: must_be_immutable
class ToDoTileWidget extends StatefulWidget {
  const ToDoTileWidget({
    super.key,
    required this.todoItem,
  });
  final Todos? todoItem;

  @override
  State<ToDoTileWidget> createState() => _ToDoTileWidgetState();
}

class _ToDoTileWidgetState extends State<ToDoTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
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
              //fix
              value: widget.todoItem?.complete,
              onChanged: (value) {
                setState(() {
                  value = value!;
                  print('basildi');
                  print(value.toString());
                });
              },
              shape: const CircleBorder(),
              activeColor: ColorConst.grey,
            ),
            // Text(widget.todoItem?.dateMilliseconds.toString() ?? ''),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //fix
                  widget.todoItem?.title.toCapitalized() ?? 'No Title',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        decoration: widget.todoItem?.complete ?? false
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 3,
                      ),
                ),
                _emptyHeightBoxLow(context),
                _TodoTileFooter(
                  todoItem: widget.todoItem,
                )
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
  const _TodoTileFooter({required this.todoItem});
  final Todos? todoItem;

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
              _CategoryChip(
                todoItem: todoItem,
              ),
              context.emptySizedWidthBoxLow,
              _PriorityChip(todoItem: todoItem),
            ],
          )
        ],
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.todoItem});
  final Todos? todoItem;

  @override
  Widget build(BuildContext context) {
    var bgColor = ColorConst.primaryColor;
    switch (todoItem?.priorty) {
      case 0:
        bgColor = ColorConst.priorityNone;
        break;
      case 1:
        bgColor = ColorConst.priorityLow;
        break;
      case 2:
        bgColor = ColorConst.priorityMedium;
        break;
      case 3:
        bgColor = ColorConst.priorityHigh;
        break;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
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
  const _CategoryChip({required this.todoItem});
  final Todos? todoItem;

  @override
  Widget build(BuildContext context) {
    final hexColor = '${todoItem?.categoryColor ?? #ffffff} ';
    final categoryBackgroundColor =
        Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: categoryBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        child: Row(
          children: [
            context.emptySizedWidthBoxLow,
            //fix
            Text(todoItem?.category.toCapitalized() ?? 'None Category')
          ],
        ),
      ),
    );
  }
}
