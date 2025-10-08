class DateTimeUtil {

  // Find the most recent Saturday
  static DateTime getWeekStart(DateTime date) {
    int daysFromSaturday = (date.weekday - DateTime.saturday) % 7;
    return date.subtract(Duration(days: daysFromSaturday));
  }

  static String formatDateForApi(DateTime date) {
    // Format: '2025-09-08'
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static DateTime parseApiDate(String dateString) {
    // Parse '2025-09-08' format back to DateTime
    final parts = dateString.split('-');
    if (parts.length != 3) {
      return DateTime.now(); // Fallback to current date if parsing fails
    }

    final year = int.tryParse(parts[0]) ?? DateTime.now().year;
    final month = int.tryParse(parts[1]) ?? DateTime.now().month;
    final day = int.tryParse(parts[2]) ?? DateTime.now().day;

    return DateTime(year, month, day);
  }

  static String formatNewsDate(String dateString) {
    try {
      // Parse the ISO 8601 format (2025-10-08T05:50:57Z)
      final dateTime = DateTime.parse(dateString);

      // Get the day with ordinal suffix
      final day = dateTime.day;
      final dayWithSuffix = _getDayWithOrdinal(day);

      // Get full month name
      final monthName = _getFullMonthName(dateTime.month);

      // Get year
      final year = dateTime.year;

      return '$dayWithSuffix $monthName, $year';
    } catch (e) {
      // Return original string or fallback if parsing fails
      return dateString;
    }
  }

  static String _getDayWithOrdinal(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }

    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  static String _getFullMonthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }
}