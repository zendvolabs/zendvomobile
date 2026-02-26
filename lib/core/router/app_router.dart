import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/features/auth/presentation/pages/email_verification_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/login/login_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/register_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/email-verification',
        name: 'email-verification',
        builder: (context, state) {
          final email =
              state.uri.queryParameters['email'] ?? 'jo***3@gmail.com';
          return EmailVerificationScreen(email: email);
        },
      ),
      // Add more routes here as your app grows
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
  );
}
