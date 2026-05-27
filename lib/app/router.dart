import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/features/auth/presentation/pages/welcome_screen.dart';
import 'package:sigma/features/auth/presentation/pages/permissions_screen.dart';
import 'package:sigma/features/auth/presentation/pages/login_screen.dart';
import 'package:sigma/features/auth/presentation/pages/verification_screen.dart';
import 'package:sigma/features/auth/presentation/pages/profile_setup_screen.dart';
import 'package:sigma/features/home/presentation/pages/home_screen.dart';
import 'package:sigma/features/chat/presentation/pages/chat_screen.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';

GoRouter createRouter(AuthViewModel authViewModel) {
  return GoRouter(
    initialLocation: '/welcome',
    refreshListenable: authViewModel,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = authViewModel.state;
      debugPrint('DEBUG Router: Path ${state.matchedLocation} | Status ${authState.status}');
      
      if (!authState.initialized) {
        debugPrint('DEBUG Router: Not initialized yet');
        return null;
      }

      final isPublicRoute = state.matchedLocation == '/login' || 
                            state.matchedLocation == '/verification' || 
                            state.matchedLocation == '/welcome' ||
                            state.matchedLocation == '/permissions' ||
                            state.matchedLocation == '/profile_setup';

      if (authState.status == AuthStatus.unauthenticated || authState.status == AuthStatus.idle) {
        if (!isPublicRoute) {
          debugPrint('DEBUG Router: Redirecting to /welcome (private route)');
          return '/welcome';
        }
        return null;
      }

      if (authState.status == AuthStatus.authenticated) {
        if (state.matchedLocation != '/profile_setup') {
          debugPrint('DEBUG Router: Redirecting to /profile_setup');
          return '/profile_setup';
        }
        return null;
      }

      if (authState.status == AuthStatus.verified) {
        if (isPublicRoute) {
          debugPrint('DEBUG Router: Redirecting to /home');
          return '/home';
        }
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/verification',
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return VerificationScreen(phoneNumber: phone);
        },
      ),
      GoRoute(
        path: '/profile_setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        builder: (context, state) {
          final chatId = state.pathParameters['id']!;
          return ChatScreen(chatId: chatId);
        },
      ),
    ],
  );
}
