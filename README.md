# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<p>
<img src="https://user-images.githubusercontent.com/120082785/220397599-f5b30425-689b-459b-a885-142f62cde580.png" height="50%" width="30%">
<img src="https://user-images.githubusercontent.com/120082785/220398046-f935dcc0-6bfe-453e-8990-c8b968a9abf0.png" height="100%" width="30%">
</p>
if (kIsWeb) {
      // Replace splash with home in history
      html.window.history.replaceState(null, '', '/home');
      
      // Add an extra entry to prevent going back
      html.window.history.pushState(null, '', '/home');
      
      _subscription = html.window.onPopState.listen((event) {
        // If user clicks back, push two new states
        html.window.history.pushState(null, '', '/home');
        html.window.history.pushState(null, '', '/home');
      });
    }


import 'package:auto_route/auto_route.dart';
import 'package:me/routes/app_route_path.dart';
import 'package:me/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override 
  final List<AutoRoute> routes = [
    AutoRoute(
      path: AppRoutePath.splash,
      page: SplashRoute.page,
      initial: true,
    ),
    AutoRoute(
      path: AppRoutePath.home,
      page: HomeRoute.page,
    ),
    AutoRoute(
      path: AppRoutePath.dashboard,
      page: DashboardRoute.page,
      children: [
        AutoRoute(
          path: AppRoutePath.users,
          page: UserListRoute.page,
        ),
      ],
    ),
  ];
} 

class AppRoutePath {
  static const String splash = '/';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String users = 'users';
} 

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../services/navigation_service.dart';
import '../../../../routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      await context.router.replace(HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/logo.png'),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:me/routes/app_router.gr.dart';
import '../widgets/workout_card.dart';
import '../widgets/exercise_card.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children:  [
          InkWell(onTap: () {
              context.pushRoute(DashboardRoute());
          },child: WorkoutCard()),
          ExerciseCard(),
        ],
      ),
    );
  }
} 

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_strategy/url_strategy.dart';
import 'routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  setPathUrlStrategy();

  GetIt.I.registerSingleton<AppRouter>(AppRouter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = GetIt.I<AppRouter>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gym App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routeInformationProvider: _appRouter.routeInfoProvider(),
    );
  }
}

