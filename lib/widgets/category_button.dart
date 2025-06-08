// category_button.dart
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final IconData? icon;

  const CategoryButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.margin = EdgeInsets.zero,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;
    final iconColor = isSelected ? Colors.white : Colors.black;
    final width = MediaQuery.of(context).size.width / 8;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 16, vertical: 20)
            : padding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              isSelected
                  ? const Color(0xFF499FFF)
                  : Color(0xFF94CFFF).withValues(alpha: .6),
              isSelected
                  ? Color(0xFF9F55FE)
                  : Color(0xFF9F55FE).withValues(alpha: .6),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: icon == null
            ? Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: width / 5,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 16, color: iconColor),
                  SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
