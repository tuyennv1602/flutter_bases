import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

extension ClickableExtensions on Widget {
  Widget clickable(
    void Function() action, {
    bool opaque = true,
    Function(PointerHoverEvent)? onHover,
    Function(PointerExitEvent)? onExit,
  }) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        opaque: opaque,
        onHover: kIsWeb ? onHover : null,
        onExit: kIsWeb ? onExit : null,
        child: this,
      ),
    );
  }
}
