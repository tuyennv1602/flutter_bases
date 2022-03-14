import 'package:flutter/material.dart';

const double _kBaseAppBarHeight = 68;

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  /// the right widgets to do some action
  final List<Widget>? actions;

  /// header title
  final Widget? title;

  /// custom param to show back button.
  /// If [canGoBack] = true and [Navigator.canPop(context)], back button will be shown
  final bool canGoBack;

  /// show bottom divider, default [showDivider] = false
  final bool showDivider;

  BaseAppBar({
    Key? key,
    this.title,
    this.actions,
    this.canGoBack = true,
    this.showDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (canGoBack && Navigator.canPop(context))
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 16),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: title ?? const SizedBox(),
                  ),
                ),
                ...(actions ?? [])
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              endIndent: 24,
              indent: 24,
              color: Colors.grey[200],
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_kBaseAppBarHeight);
}
