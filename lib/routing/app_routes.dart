import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routing.dart';
import 'base/routes.dart';

class AppNavigator extends NavigatorRouteDelegate<AppPageRoute> {
  factory AppNavigator.of(BuildContext context) =>
      Provider.of<AppNavigator>(context, listen: false);

  AppNavigator(AppPageRoute initialPath) : super(initialPath);

  void clearAndToSplash() => clearAndPushTo(AppPageRoute.splash());

  void toHome() => pushTo(AppPageRoute.home());

  void slideUpToHome() => pushTo(AppPageRoute.homeSlideUp());

  void fadeToHome() => pushTo(AppPageRoute.homeFade());

  void scaleToHome() => pushTo(AppPageRoute.homeScale());

  void callback(VoidCallback onRefresh) =>
      pushTo(AppPageRoute.callback(onRefresh));
}

extension AppNavigatorEx on BuildContext {
  AppNavigator get navigator => AppNavigator.of(this);

  bool pop() => navigator.pop();

  void pushTo(AppPageRoute path) => navigator.pushTo(path);

  void pushAndPopTo(AppPageRoute pushPath, AppPageRoute popToPath) =>
      navigator.pushAndPopTo(pushPath, popToPath);

  void replaceLast(AppPageRoute path) => navigator.replaceLast(path);

  void popToTop() => navigator.popToTop();

  StreamSubscription listen(Function(String route) onUpdated) =>
      navigator.listen(onUpdated);
}
