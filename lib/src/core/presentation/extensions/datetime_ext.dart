extension Format on DateTime {
  // get string with format 'dd/MM/yyyy HH:mm'
  String get formatted {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
