import 'package:flutter/material.dart';
import 'package:flutter_base/features/home/home_screen.dart';
import 'package:flutter_base/features/splash/splash_screen.dart';

import 'base/routes.dart';
import 'route_name.dart';

class AppPageRoute extends NavRoute {
  AppPageRoute(
    String id, {
    required NavPageBuilder builder,
    dynamic data,
  }) : super(id, builder: builder, data: data);

  static AppPageRoute splash() =>
      AppWidgetRoute(RouteName.splash, builder: splashScreenBuilder);

  static AppPageRoute home() =>
      AppWidgetRoute(RouteName.home, builder: homeScreenBuilder);

  static AppPageRoute homeSlideUp() => AppWidgetRoute(
        RouteName.home,
        builder: homeScreenBuilder,
        transition: RouteTransition.slideUp,
      );

  static AppPageRoute homeFade() => AppWidgetRoute(
        RouteName.home,
        builder: homeScreenBuilder,
        transition: RouteTransition.fade,
      );

  static AppPageRoute homeScale() => AppWidgetRoute(
        RouteName.home,
        builder: homeScreenBuilder,
        transition: RouteTransition.scale,
      );

  static AppPageRoute callback(VoidCallback onRefresh) => AppWidgetRoute(
        RouteName.home,
        builder: (context) => homeScreenBuilder(context, onRefresh: onRefresh),
      );
}

class AppWidgetRoute extends AppPageRoute {
  AppWidgetRoute(
    String id, {
    required WidgetBuilder builder,
    dynamic data,
    RouteTransition transition = RouteTransition.platform,
    Duration? transitionDuration,
  }) : super(
          id,
          builder: (context, [dynamic data]) => _widgetToPage(
            context,
            id,
            builder,
            data,
            transition,
            transitionDuration,
          ),
          data: data,
        );

  static Page _widgetToPage(
    BuildContext context,
    String key,
    WidgetBuilder builder,
    dynamic data,
    RouteTransition? transition,
    Duration? transitionDuration,
  ) {
    return RoutePage(
      child: builder(context),
      key: ValueKey(key),
      name: key,
      arguments: data,
      transition: transition,
      transitionDuration: transitionDuration,
      fullscreenDialog: transition != RouteTransition.platform,
    );
  }
}
