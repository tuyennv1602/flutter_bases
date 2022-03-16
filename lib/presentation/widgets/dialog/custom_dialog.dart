import 'package:flutter/material.dart';
import 'package:flutter_base/styles.dart';
import 'package:flutter_base/core_packages.dart';

const _actionButtonHeight = 50;

/// Displays a custom dialog widget
///
/// The [message] information message
///
/// The [title] dialog title. Default is "Notification"
///
/// The [insetPadding] padding between dialog and edges of device
///
/// The [child] allow add widget between message and bottom action buttons
///
/// The [backgroundColor] is background of content dialog
///
/// The [alignment] dialog position
///

class CustomDialog extends StatelessWidget {
  final EdgeInsets? insetPadding;
  final Widget? bottomActions;
  final Widget? child;
  final String? title;
  final String? message;
  final Color backgroundColor;
  final Alignment alignment;
  final bool preventDefaultPop;

  const CustomDialog.custom({
    Key? key,
    this.message,
    this.title,
    this.insetPadding,
    this.child,
    this.backgroundColor = Colors.white,
    this.alignment = Alignment.center,
    this.bottomActions,
    this.preventDefaultPop = false,
  }) : super(key: key);

  /// Information dialog show [title], [message] and only one action button
  CustomDialog.info(
    this.message, {
    Key? key,
    VoidCallback? onConfirmed,
    String? confirmTitle,
    this.title,
    this.insetPadding,
    this.child,
    this.backgroundColor = Colors.white,
    this.alignment = Alignment.center,
    this.preventDefaultPop = false,
  })  : bottomActions = _BottomActions(
          onConfirmed: onConfirmed,
          confirmTitle: confirmTitle,
        ),
        super(key: key);

  /// Information dialog show [title], [message] and 2 action buttons for canceling and confirming
  CustomDialog.confirm(
    this.message, {
    Key? key,
    VoidCallback? onConfirmed,
    VoidCallback? onCanceled,
    String? confirmTitle,
    String? cancelTitle,
    this.title,
    this.insetPadding,
    this.child,
    this.backgroundColor = Colors.white,
    this.alignment = Alignment.center,
    this.preventDefaultPop = false,
  })  : bottomActions = _BottomActions(
          onConfirmed: onConfirmed,
          onCanceled: onCanceled,
          confirmTitle: confirmTitle,
          cancelTitle: cancelTitle,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Align(
        alignment: alignment,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Dialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    'Message',
                    style: TextStyles.medium400,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 5, left: 15, right: 15),
                    child: Text(
                      message!,
                      style: TextStyles.small400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                Flexible(child: SingleChildScrollView(child: child ?? const SizedBox())),
                bottomActions ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final String? cancelTitle;
  final String? confirmTitle;
  final VoidCallback? onCanceled;
  final VoidCallback? onConfirmed;
  final bool preventDefaultPop;

  const _BottomActions({
    Key? key,
    this.onCanceled,
    this.onConfirmed,
    this.confirmTitle,
    this.cancelTitle,
    this.preventDefaultPop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        Row(
          children: [
            Expanded(
              child: onCanceled != null
                  ? ElevatedButton(onPressed: onCanceled, child: Text(cancelTitle ?? 'Cancel'))
                  : const SizedBox(),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (!preventDefaultPop) {
                    Navigator.of(context).pop();
                  }
                  onConfirmed?.call();
                },
                child: Text(confirmTitle ?? 'OK'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
