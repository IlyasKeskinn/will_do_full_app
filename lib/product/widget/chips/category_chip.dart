import 'package:flutter/material.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';
import 'package:will_do_full_app/product/model/categories.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.categoryItems,
    this.isSelected = false,
  });
  final Categories? categoryItems;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final hexColor = '${categoryItems?.categoryColor ?? #ffffff} ';
    final categoryBackgroundColor =
        Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);

    return Chip(
      elevation: 2,
      padding: const EdgeInsets.all(14),
      label: Text(categoryItems?.name ?? 'None category'),
      labelStyle: TextStyle(color: ColorConst.white),
      backgroundColor: isSelected
          ? categoryBackgroundColor.withOpacity(0.7)
          : categoryBackgroundColor.withOpacity(0.2),
    );
  }
}
