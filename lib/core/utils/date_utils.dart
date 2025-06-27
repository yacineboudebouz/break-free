import 'package:intl/intl.dart';

/// Utility class for date and time operations throughout the app
class DateUtils {
  // Date format patterns
  static const String defaultDateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const String timeOnlyFormat = 'hh:mm a';
  static const String iso8601Format = 'yyyy-MM-ddTHH:mm:ss.SSSZ';

  /// Get current date as string in default format
  static String getCurrentDate() {
    return DateFormat(defaultDateFormat).format(DateTime.now());
  }

  /// Get current date and time as ISO 8601 string
  static String getCurrentDateTime() {
    return DateTime.now().toIso8601String();
  }

  /// Format date for display
  static String formatDateForDisplay(DateTime date) {
    return DateFormat(displayDateFormat).format(date);
  }

  /// Format date and time for display
  static String formatDateTimeForDisplay(DateTime dateTime) {
    return DateFormat(displayDateTimeFormat).format(dateTime);
  }

  /// Format time only for display
  static String formatTimeForDisplay(DateTime dateTime) {
    return DateFormat(timeOnlyFormat).format(dateTime);
  }

  /// Parse date string to DateTime
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Convert DateTime to database format string
  static String toDatabase(DateTime date) {
    return DateFormat(defaultDateFormat).format(date);
  }

  /// Get days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Get relative date string (Today, Yesterday, or formatted date)
  static String getRelativeDateString(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      return formatDateForDisplay(date);
    }
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
}
