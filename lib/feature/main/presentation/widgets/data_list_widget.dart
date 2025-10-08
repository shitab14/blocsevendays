// data_list_widget.dart
import 'package:blocsevendays/core/utils/logger.dart';
import 'package:blocsevendays/feature/main/domain/article_entity.dart';
import 'package:blocsevendays/feature/main/presentation/bloc/bloc_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_time_util.dart';

class DataListWidget extends StatelessWidget {
  const DataListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        // AppLogger.debug("SHITAB: data_list_widget1: "+ state.articles.length.toString());
      },
      builder: (context, state) {
        if (state.status == MainStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MainStatus.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  AppConstants.failedToLoad,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    GetNewsEvent(AppConstants.q, DateTimeUtil.formatDateForApi(state.currentWeekStart), AppConstants.sortBy);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.status == MainStatus.success) {
          final items = state.articles;
          // AppLogger.debug("SHITAB: data_list_widget: "+ items.length.toString());
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_alt,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppConstants.noDataAvailable,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildListItem(context, item, index);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildListItem(BuildContext context, ArticleEntity item, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title ?? 'No Title',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.author ?? 'No Author',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${DateTimeUtil.formatNewsDate(item.publishedAt ?? '')}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}