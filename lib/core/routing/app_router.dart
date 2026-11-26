// lib/core/routing/app_router.dart
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:workbridge/generated/l10n.dart';

import 'package:workbridge/features/auth/presentation/pages/login/login_screen.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/steps/choose_path.dart';
import 'package:workbridge/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:workbridge/features/home/presentation/pages/home_screen.dart';
import 'package:workbridge/features/splash/presentation/pages/splash_screen.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String choosePath = '/choose_path';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String jobDetails = '/job-details';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,

  errorBuilder: (context, state) {
    final l10n = S.of(context);
    return Scaffold(body: Center(child: Text('${l10n.notFoundRoute} ${state.error}')));
  },

  routes: [
    GoRoute(path: AppRoutes.splash, name: 'splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: AppRoutes.login, name: 'login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: AppRoutes.choosePath, name: 'choose_path', builder: (context, state) => const ChoosePathScreen()),
    GoRoute(path: AppRoutes.signup, name: 'signup', builder: (context, state) => SignupScreen()),
    GoRoute(path: AppRoutes.home, name: 'home', builder: (context, state) => const HomeScreen()),
    // (Path Parameters / Extra Object)
    // GoRoute(
    //   path: '${AppRoutes.jobDetails}/:id',
    //   name: 'jobDetails',
    //   builder: (context, state) {
    //     final jobId = state.pathParameters['id']!;
    //     return JobDetailsScreen(jobId: jobId);
    //   },
    // ),
  ],
);
