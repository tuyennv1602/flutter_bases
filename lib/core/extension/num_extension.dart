extension NumExtension on int {
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);
}
