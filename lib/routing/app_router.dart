import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routing.dart';
import 'base/routes.dart';

class AppNavigator extends NavigatorRouteDelegate<AppPageRoute> {
  factory AppNavigator.of(BuildContext context) =>
      Provider.of<AppNavigator>(context, listen: false);

  AppNavigator(AppPageRoute initialPath) : super(initialPath);

  void clearAndToSplash() => clearAndPush(AppPageRoute.splash());
}

extension AppNavigatorEx on BuildContext {
  AppNavigator get appNavigator => AppNavigator.of(this);

  bool pop() => appNavigator.pop();

  void pushTo(AppPageRoute path) => appNavigator.pushTo(path);

  void pushAndPopTo(AppPageRoute pushPath, AppPageRoute popToPath) =>
      appNavigator.pushAndPopTo(pushPath, popToPath);

  void replaceLast(AppPageRoute path) => appNavigator.replaceLast(path);

  void popToTop() => appNavigator.popToTop();

  StreamSubscription didUpdateLastRoute(Function(String route) onUpdated) =>
      appNavigator.didUpdateLastRoute(onUpdated);
}
