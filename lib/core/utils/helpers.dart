class AppHelpers {
  AppHelpers._();

  static String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  static String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  static String truncateText(String value, {int maxLength = 40}) {
    if (value.length <= maxLength) return value;

    return '${value.substring(0, maxLength)}...';
  }
}
