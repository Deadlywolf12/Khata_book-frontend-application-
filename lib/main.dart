import 'package:flutter/material.dart';
import 'package:khatabookn/database/app_database.dart';
import 'package:khatabookn/provider/auth_pro.dart';
import 'package:khatabookn/provider/theme_pro.dart';
import 'package:khatabookn/provider/user_profile_pro.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final AppDatabase appDatabase = AppDatabase();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider(appDatabase)),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class AppLifecycleHandler extends WidgetsBindingObserver {
  final AuthProvider auth;
  AppLifecycleHandler(this.auth);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      auth.logoutOnBackground();
    }
    if (state == AppLifecycleState.resumed) {
      auth.checkBackgroundLock();
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLifecycleHandler? _lifecycleHandler;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_lifecycleHandler == null) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      _lifecycleHandler = AppLifecycleHandler(auth);
      WidgetsBinding.instance.addObserver(_lifecycleHandler!);
    }
  }

  @override
  void dispose() {
    if (_lifecycleHandler != null) {
      WidgetsBinding.instance.removeObserver(_lifecycleHandler!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp.router(
      title: 'KhataBook',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: MyRouter.router,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            padding: mediaQuery.padding.copyWith(bottom: 0),
          ),
          child: ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: double.infinity,
            minWidth: 450,
            defaultScale: true,
            breakpoints: const [
              ResponsiveBreakpoint.resize(450, name: MOBILE),
              ResponsiveBreakpoint.resize(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: TABLET),
              ResponsiveBreakpoint.autoScale(double.infinity, name: DESKTOP),
            ],
          ),
        );
      },
    );
  }
}