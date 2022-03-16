import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _loadingDialogSize = 30;

class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: _loadingDialogSize,
        width: _loadingDialogSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}
