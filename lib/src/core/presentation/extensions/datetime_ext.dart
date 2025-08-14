extension Format on DateTime {
  // get string with format 'dd/MM/yyyy HH:mm'
  String get formatted {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  // format month day, year hour:minute AM/PM
  String get formattedAmPm {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final amPm = hour < 12 ? 'AM' : 'PM';
    return "${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year $hour12:${minute.toString().padLeft(2, '0')} $amPm";
  }

  String differenceFormatted(DateTime other) {
    final diff = difference(other);
    if (diff.inDays > 0) {
      return "${diff.inDays} days ago";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} hours ago";
    } else {
      return "${diff.inMinutes} minutes ago";
    }
  }
}
