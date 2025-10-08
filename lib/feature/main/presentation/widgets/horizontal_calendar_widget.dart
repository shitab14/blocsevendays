import 'package:blocsevendays/core/utils/constants.dart';
import 'package:blocsevendays/feature/main/presentation/bloc/bloc_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_time_util.dart';
import 'calendar_date_widget.dart';

class HorizontalCalendarWidget extends StatefulWidget {
  const HorizontalCalendarWidget({super.key});

  @override
  State<HorizontalCalendarWidget> createState() => _HorizontalCalendarWidgetState();
}

class _HorizontalCalendarWidgetState extends State<HorizontalCalendarWidget> {
  late PageController _pageController;
  int _currentPage = 500;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              final direction = page - _currentPage;
              _currentPage = page;

              if (direction != 0) {
                context.read<MainBloc>().add(ChangeWeekEvent(direction));
              }
            },
            itemBuilder: (context, pageIndex) {
              final baseWeek = DateTimeUtil.getWeekStart(DateTime.now());
              final weekStart = baseWeek.add(Duration(days: (pageIndex - 500) * 7));
              final weekDates = _generateWeekDates(weekStart);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: weekDates.map((date) {
                    return CalendarDateWidget(
                      date: date,
                      isSelected: _isDateSelected(date, state),
                      onTap: () => _onDateSelected(date, context),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<DateTime> _generateWeekDates(DateTime startDate) {
    return List.generate(7, (index) => startDate.add(Duration(days: index)));
  }

  bool _isDateSelected(DateTime date, MainState state) {
    if (state.selectedDate == null) {
      final now = DateTime.now();
      return date.year == now.year && date.month == now.month && date.day == now.day;
    }

    final selected = DateTimeUtil.parseApiDate(state.selectedDate!);
    return date.year == selected.year &&
        date.month == selected.month &&
        date.day == selected.day;
  }

  void _onDateSelected(DateTime date, BuildContext context) {
    context.read<MainBloc>().add(SelectDateEvent(date));
    context.read<MainBloc>().add(
        GetNewsEvent(AppConstants.q, DateTimeUtil.formatDateForApi(date), AppConstants.sortBy)
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}