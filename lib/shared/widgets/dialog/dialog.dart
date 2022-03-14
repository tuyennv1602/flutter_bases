import 'package:flutter/material.dart';
import 'custom_dialog.dart';
import 'loading_dialog.dart';

/// Displays a dialog
///
/// The [child] argument is used to pass custom dialog that you want to show
///
/// The [barrierColor] argument is used to pass custom overlay background color
///
/// The [dismissible] argument is used to allow dismiss dialog when tap outside dialog
///
/// The [allowOverlap] argument is used to avoid next dialog show when current is showing.
///

Future<void> showAppDialog(
  BuildContext context, {
  required CustomDialog child,
  Color? barrierColor = Colors.black45,
  bool dismissible = false,
  bool allowOverlap = false,
}) async {
  if (!_DialogManager().allowOverlap || _DialogManager().isLoading) {
    return;
  }
  _DialogManager().setAllowOverlap = allowOverlap;
  await showDialog(
    context: context,
    barrierDismissible: dismissible,
    barrierColor: barrierColor,
    useSafeArea: false,
    builder: (_) => child,
  );
  _DialogManager().resetOverlap();
}

Future<void> showAppLoadingDialog(
  BuildContext context, {
  Color? barrierColor = Colors.black45,
}) async {
  _DialogManager().setLoading = true;
  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: barrierColor,
    useSafeArea: false,
    builder: (_) => const AppLoadingDialog(),
  );
  _DialogManager().setLoading = false;
}

Future<void> hideAppLoadingDialog(BuildContext context) async {
  if (_DialogManager().isLoading) {
    Navigator.of(context).pop();
    _DialogManager().setLoading = false;
  }
}

/// Manage overlap state
class _DialogManager {
  factory _DialogManager() {
    return _instance;
  }
  _DialogManager._();

  static final _DialogManager _instance = _DialogManager._();

  bool _allowOverlap = true;

  set setAllowOverlap(bool value) => _allowOverlap = value;

  bool get allowOverlap => _allowOverlap;

  void resetOverlap() => _allowOverlap = true;

  bool _isLoading = false;

  set setLoading(bool value) => _isLoading = value;

  bool get isLoading => _isLoading;
}
