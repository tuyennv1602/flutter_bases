import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isNullOrEmpty() =>
      trim().isEmpty || trim().toLowerCase() == 'null' || trim().toLowerCase() == '""';

  bool isNotNullOrEmpty() => trim().isNotEmpty;

  bool isEmail() {
    if (trim().isEmpty) return false;
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(trim());
  }

  bool isValidPassword() {
    if (trim().isEmpty) return false;

    return RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$").hasMatch(this);
  }

  DateTime toDateTime({String? format}) => DateFormat(format ?? 'dd/MM/yyyy HH:mm').parse(this);

  String get getExtention {
    return split('.').last;
  }
}
