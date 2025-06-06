// calendar_day_widget.dart
import 'package:flutter/material.dart';

class CalendarDayWidget extends StatelessWidget {
  final String day;
  final String weekday;
  final String dateLabel;
  final bool isSelected;
  final bool isToday;
  final bool hasData;
  final VoidCallback onTap;

  const CalendarDayWidget({
    super.key,
    required this.day,
    required this.weekday,
    required this.dateLabel,
    required this.isSelected,
    required this.isToday,
    this.hasData = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              day,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dateLabel,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 10,
              ),
            ),
            if (hasData)
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
