extension DateTimeFormatter on DateTime {
  String toDateString() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return "$hour:$minute, $day.$month.$year";
  }
}
