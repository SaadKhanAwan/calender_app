// calendar_day_widget.dart
import 'package:flutter/material.dart';

class CalendarDayWidget extends StatelessWidget {
  final String day;
  final String weekday;
  final String dateLabel;

  final bool isSelected, isToday;
  final VoidCallback onTap;

  const CalendarDayWidget({
    super.key,
    required this.day,
    required this.weekday,
    required this.dateLabel,
    required this.isSelected,
    required this.onTap,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            weekday,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 56,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.9)
                  : isToday
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isToday && !isSelected
                  ? Border.all(color: Colors.white.withOpacity(0.5))
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: isSelected ? 8 : 0),
                isSelected
                    ? Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF9B59B6).withOpacity(0.9),
                        ))
                    : SizedBox(),
                Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Color(0xFF9B59B6) : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  dateLabel,
                  style: TextStyle(
                    color: isSelected
                        ? Color(0xFF9B59B6)
                        : Colors.white.withOpacity(0.8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
