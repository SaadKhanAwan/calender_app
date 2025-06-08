import 'package:custom_calandar_list/widgets/calendar_day_widget.dart';
import 'package:custom_calandar_list/widgets/category_button.dart';
import 'package:custom_calandar_list/widgets/content_item.dart';
import 'package:flutter/material.dart';

class CalandarListView extends StatefulWidget {
  const CalandarListView({super.key});

  @override
  CalandarListViewState createState() => CalandarListViewState();
}

class CalandarListViewState extends State<CalandarListView> {
  int selectedTabIndex = 0;
  int selectedCategoriesIndex = 0;
  final List<String> tabs = ['公众号', '小红书', '抖音', '快手', '第'];
  final List<String> categories = ['热门内容', '热点事件', '热门专题', '爆款标题'];

  DateTime selectedDate = DateTime.now();
  final PageController _pageController = PageController(initialPage: 1000);
  int currentWeekIndex = 1000;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 360,
                padding: const EdgeInsets.only(top: 60),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF499FFF),
                      const Color(0xFFA650FE),
                      Colors.grey.shade200,
                      Colors.grey.shade100,
                    ],
                  ),
                ),
                child: _buildCalendar(),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCategories(),
                  _buildTabs(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildContentList()),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _showDatePicker,
                child: Row(
                  children: [
                    Text(
                      '${selectedDate.year} / ${selectedDate.month.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
              ),
              Spacer(),
              Text(
                '众号',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    '公众',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 3,
                    width: 30,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(width: 10),
              Text(
                '公众号',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 92,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentWeekIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildWeekView(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekView(int weekIndex) {
    // Calculate the start of the week based on the current selected date and week offset
    DateTime baseDate = selectedDate;
    int weekOffset = weekIndex - 1000; // 1000 is our starting point
    DateTime weekStart = baseDate.add(Duration(days: weekOffset * 7));

    // Get the start of the week (Sunday)
    DateTime startOfWeek =
        weekStart.subtract(Duration(days: weekStart.weekday % 7));

    List<String> weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    List<String> dateLabels = List.generate(7, (index) {
      DateTime currentDay = startOfWeek.add(Duration(days: index));
      return '${currentDay.day}日';
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        DateTime currentDay = startOfWeek.add(Duration(days: index));
        bool isSelected = currentDay.day == selectedDate.day &&
            currentDay.month == selectedDate.month &&
            currentDay.year == selectedDate.year;
        bool isToday = currentDay.day == DateTime.now().day &&
            currentDay.month == DateTime.now().month &&
            currentDay.year == DateTime.now().year;

        return CalendarDayWidget(
          day: currentDay.day.toString(),
          weekday: weekdays[index],
          dateLabel: dateLabels[index],
          isSelected: isSelected,
          isToday: isToday,
          onTap: () {
            setState(() {
              selectedDate = currentDay;
            });
            print('Selected Day: $currentDay');
          },
        );
      }),
    );
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF9B59B6),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        // Reset page controller to center when date changes significantly
        _pageController.animateToPage(
          1000,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        currentWeekIndex = 1000;
      });
      print('Selected Date from Picker: $pickedDate');
    }
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.asMap().entries.map((category) {
          int index = category.key;
          String categoryValue = category.value;
          bool isSelected = index == selectedCategoriesIndex;

          return CategoryButton(
            label: categoryValue,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                selectedCategoriesIndex = index;
              });
              print('Selected category: $category');
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabs() {
    final width = MediaQuery.of(context).size.width / 8;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            int index = entry.key;
            String tab = entry.value;
            bool isSelected = index == selectedTabIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
                print('Selected tab: $tab');
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isSelected ? Color(0xFF499FFF) : Colors.white,
                      isSelected ? Color(0xFF9B59B6) : Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.wechat,
                      size: width / 2,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: width / 3.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDropdowns() {
    return Container(
      margin: const EdgeInsets.only(right: 60, left: 60, top: 20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '全部分类',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 16),
            ],
          ),
          Row(
            children: [
              Text(
                '全部类型',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildDropdowns(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ContentItem(rank: index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
