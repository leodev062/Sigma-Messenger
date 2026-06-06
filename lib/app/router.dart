import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import '../presentation/pages/home_screen.dart';

GoRouter createRouter(AuthViewModel authViewModel) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: authViewModel,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = authViewModel.state;

      debugPrint('DEBUG Router: Path ${state.matchedLocation} | Status ${authState.status}');
      
      if (!authState.initialized) {
        return null; // Aguarda a inicialização do AuthViewModel
      }

      final isPublicRoute = state.matchedLocation.startsWith('/registration/') ||
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
        if (authState.pendingProfileSetup && state.matchedLocation != '/profile_setup') {
          debugPrint('DEBUG Router: Redirecting to /profile_setup (pending profile)');
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
        builder: (context, state) => WelcomeScreen(
          onEvent: (event) {
            if (event is Continue) {
              context.push('/permissions');
            }
          },
        ),
      ),
      GoRoute(
        path: '/registration/country_picker',
        builder: (context, state) {
          return ChangeNotifierProvider<CountryCodePickerViewModel>(
            create: (_) => CountryCodePickerViewModel(
              repository: CountryCodePickerRepository(),
              onResult: (country) => context.pop(country),
            ),
            child: const CountryCodePickerScreen(),
          );
        },
      ),
      GoRoute(
        path: '/registration/phone_number',
        builder: (context, state) {
          return ChangeNotifierProvider<PhoneNumberEntryViewModel>(
            create: (_) => PhoneNumberEntryViewModel(
              requestVerificationInteractor: locator<RequestVerificationInteractor>(),
              onNavigateToCountryPicker: () => context.push('/registration/country_picker'),
              onNavigateToVerification: (phone, sessionId) => context.push(
                '/registration/verification',
                extra: {'phone': phone, 'sessionId': sessionId},
              ),
            ),
            child: const PhoneNumberEntryScreen(),
          );
        },
      ),
      GoRoute(
        path: '/registration/verification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final phone = extra['phone'] as String? ?? '';
          final sessionId = extra['sessionId'] as String? ?? '';
          
          return ChangeNotifierProvider<VerificationCodeViewModel>(
            create: (_) => VerificationCodeViewModel(
              repository: locator<IRegistrationRepository>(),
              verifyCodeInteractor: locator<VerifyCodeInteractor>(),
              authViewModel: authViewModel,
              sessionId: sessionId,
              initialE164: phone,
              onNavigateToPhoneNumber: () => context.pop(),
              onVerificationSuccess: () => context.go('/profile_setup'),
            ),
            child: const VerificationCodeScreen(),
          );
        },
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
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
      GoRoute(
        path: '/archived',
        builder: (context, state) => const ArchivedChatsScreen(),
      ),
    ],
  );
}
