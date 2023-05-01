import 'package:flutter/material.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/model/priorities.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({
    required this.priorityItem,
    this.isSelected = false,
  });
  final Priorities? priorityItem;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final hexColor = '${priorityItem?.color ?? #ffffff} ';
    final priorityColor =
        Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? priorityColor : priorityColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
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
              color:
                  isSelected ? priorityColor : priorityColor.withOpacity(0.3),
            ),
            Text(
              priorityItem?.name ?? 'None',
              style: TextStyle(
                color:
                    isSelected ? priorityColor : priorityColor.withOpacity(0.3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
