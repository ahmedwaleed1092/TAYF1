import 'package:flutter/material.dart';

class CategoryChipsSelector extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const CategoryChipsSelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const Color selectedColor = Color(0xFF2F6BFF);
  static const Color unselectedBg = Color(0xFFEAEAEE);
  static const Color unselectedText = Color(0xFF4B4B57);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : unselectedText,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
