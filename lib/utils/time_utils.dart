String formattedTime(int _time) {
  final duration = durationOf(_time);
  return duration.inHours == 0
      ? "${duration.inMinutes} ${duration.inMinutes > 1 ? "minutes" : "minute"} ago"
      : duration.inDays == 0
          ? "${duration.inHours} ${duration.inHours > 1 ? "hours" : "hour"} ago"
          : duration.inDays < 30
              ? "${duration.inDays} ${duration.inDays > 1 ? "days" : "day"} ago"
              : "${duration.inDays / 30} ${(duration.inDays / 30) > 1 ? "months" : "month"} ${(duration.inDays % 30)} days ago";
}


Duration durationOf(int _time) {
  return DateTime.now()
      .difference(DateTime.fromMillisecondsSinceEpoch(_time));
}
