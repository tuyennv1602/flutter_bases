import 'package:flutter/material.dart';

import 'app_routing.dart';

/// Converts browser location strings to [PageConfiguration], and vice-versa.
/// This leans on [PageConfiguration] to the actual parsing, so this is largely boilerplate.
/// All most for web browser, which can paste a link then navigate to the screen
class AppRouteInformationParser extends RouteInformationParser<AppPageRoute> {
  @override
  Future<AppPageRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    // final _uri = Uri.parse(routeInformation.location ?? '');
    // final _pathSegments = _uri.pathSegments;
    // if (_pathSegments.isNotEmpty && _pathSegments.last.contains('home')) {
    //   return AppPageRoute.home();
    // }
    return AppPageRoute.splash();
  }
}
