import 'package:blocsevendays/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/date_time_util.dart';
import '../bloc/bloc_main.dart';
import '../widgets/data_list_widget.dart';
import '../widgets/horizontal_calendar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now();
      context.read<MainBloc>().add(SelectDateEvent(today));
      context.read<MainBloc>().add(
          GetNewsEvent(AppConstants.q, DateTimeUtil.formatDateForApi(today), AppConstants.sortBy)
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Data List View
            Expanded(
              child: DataListWidget(),
            ),
        
            // Horizontal Calendar View
            const HorizontalCalendarWidget(),
          ],
        ),
      ),
    );
  }

}