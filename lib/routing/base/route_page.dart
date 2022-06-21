part of routing.base;

enum RouteTransition {
  none,
  platform,
  slideUp,
  fade,
  scale,
}

const _kTransitionDuration = Duration(milliseconds: 250);

class RoutePage<T> extends Page<T> {
  final RouteTransition? transition;
  final Duration? transitionDuration;

  const RoutePage({
    required this.child,
    this.maintainState = true,
    this.fullscreenDialog = false,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
    this.transition,
    this.transitionDuration,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedMaterialPageRoute<T>(
      page: this,
      transition: transition,
      duration: transitionDuration ?? _kTransitionDuration,
    );
  }
}

class _PageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  final RouteTransition? transition;
  final Duration duration;

  _PageBasedMaterialPageRoute({
    required RoutePage<T> page,
    this.transition,
    required this.duration,
  }) : super(
          settings: page,
        ) {
    assert(opaque);
  }

  RoutePage<T> get _page => settings as RoutePage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (transition == RouteTransition.scale) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      );
    }
    if (transition == RouteTransition.fade) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
    if (transition == RouteTransition.slideUp) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    }
    if (transition == RouteTransition.platform) {
      final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
      return theme.buildTransitions<T>(
        this,
        context,
        animation,
        secondaryAnimation,
        child,
      );
    }
    return child;
  }
}
