part of routing.base;

abstract class NavigatorRouteDelegate<PathRoute extends NavRoute>
    extends RouterDelegate<PathRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  NavigatorRouteDelegate(PathRoute initialPath) {
    _routes.add(initialPath);
  }

  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  @override
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  final List<PathRoute> _routes = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(pop()),
      child: Navigator(
        key: navigatorKey,
        onPopPage: _onPopPage,
        pages: _getPages(context),
      ),
    );
  }

  List<Page> _getPages(BuildContext context) {
    return _routes.map((route) => route.builder(context)).toList();
  }

  @override
  Future<void> setNewRoutePath(PathRoute configuration) async {}

  StreamSubscription listen(Function(String route) onUpdated) {
    return _controller.stream.listen((event) {
      onUpdated(event);
    });
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    return pop();
  }

  bool pop() {
    if (canPop()) {
      _routes.removeLast();
      _controller.add(_routes.last.id);
      notifyListeners();
      return true;
    }
    return false;
  }

  bool canPop() {
    return _routes.length > 1;
  }

  void pushTo(PathRoute path) {
    if (path.id == _routes.last.id) {
      return;
    }
    _routes.add(path);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void pushAndPopTo(PathRoute pushPath, PathRoute popToPath) {
    final index = _routes.indexWhere((element) => element.id == popToPath.id);
    if (index >= 0) {
      _routes.removeRange(index + 1, _routes.length);
    }
    _routes.add(pushPath);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void replaceLast(PathRoute path) {
    if (_routes.isNotEmpty) {
      _routes.removeLast();
    }
    _routes.add(path);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void clearAndPushTo(PathRoute path) {
    _routes.clear();
    _routes.add(path);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void clearAndPushToRoutes(List<PathRoute> paths) {
    _routes.clear();
    _routes.addAll(paths);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void pushToRoutes(List<PathRoute> paths) {
    _routes.addAll(paths);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void popToTop() {
    _routes.removeRange(1, _routes.length);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void popToTopAndPushTo(PathRoute route) {
    _routes
      ..removeRange(1, _routes.length)
      ..add(route);
    _controller.add(_routes.last.id);
    notifyListeners();
  }

  void pushAndRemoveIfExisting(PathRoute route) {
    final _routeIndex =
        _routes.map((r) => r.id).toList().indexWhere((id) => id == route.id);
    if (_routeIndex != -1) {
      _routes.removeAt(_routeIndex);
    }
    _routes.add(route);
    notifyListeners();
  }
}
