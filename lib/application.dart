import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'core_packages.dart';
import 'data/api/base/api_config.dart';
import 'di/di.dart';
import 'localizations/app_localizations.dart';

Future<void> runApplication(ApiConfig config) async {
  //Call this first to make sure we can make other system level calls safely
  WidgetsFlutterBinding.ensureInitialized();
  // Status bar style on Android/iOS
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await setupDi(config);
  runApp(_AppBootstrapper());
}

// Bootstrap the app, initializing all Controllers and Services
class _AppBootstrapper extends StatefulWidget {
  @override
  _AppBootstrapperState createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<_AppBootstrapper> {
  late final AppRouteInformationParser _routeParser = AppRouteInformationParser();
  late final AppNavigator _router;

  @override
  void initState() {
    super.initState();
    _router = AppNavigator(AppPageRoute.splash());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AppNavigator>.value(value: _router),
        ChangeNotifierProvider<ThemeModel>.value(value: GetIt.I()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routeInformationParser: _routeParser,
        routerDelegate: _router,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('en', 'US')],
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          final _locale = supportedLocales.firstWhere(
            (sl) => sl.languageCode == locale?.languageCode,
            orElse: () => const Locale('en', ''),
          );
          return _locale;
        },
      ),
    );
  }
}
