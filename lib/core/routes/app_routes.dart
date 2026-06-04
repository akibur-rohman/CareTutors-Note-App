import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/controllers/onboarding_controller.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/notes/presentation/views/home_view.dart';
import '../../features/notes/presentation/views/add_note_view.dart';
import '../../features/notes/domain/model/note_model.dart';

class AppRoutes {
  AppRoutes._();

  static final router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    redirect: (context, state) {
      final onboardingController = Get.find<OnboardingController>();
      final authController = Get.find<AuthController>();

      final isGoingToOnboarding = state.matchedLocation == '/onboarding';
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';

      // 1. Onboarding Guard
      if (!onboardingController.hasSeenOnboarding) {
        if (!isGoingToOnboarding) {
          return '/onboarding';
        }
        return null;
      }

      // 2. Authentication Guard
      final isLoggedIn = authController.isAuthenticated;
      if (!isLoggedIn) {
        if (!isGoingToLogin && !isGoingToRegister && !isGoingToOnboarding) {
          return '/login';
        }
        return null;
      }

      // 3. Authenticated User Redirection
      if (isGoingToLogin || isGoingToRegister || isGoingToOnboarding) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/add-note',
        builder: (context, state) {
          final note = state.extra as NoteModel?;
          return AddNoteView(initialNote: note);
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
