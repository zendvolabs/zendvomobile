import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/features/auth/presentation/pages/create_new_password/create_new_password_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/login/login_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/register/register_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/verify_email/verify_email_screen.dart';

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
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/verify-email',
        name: 'verify-email',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final flow = state.uri.queryParameters['flow'] ?? 'register';
          return VerifyEmailScreen(email: email, flow: flow);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/create-new-password',
        name: 'create-new-password',
        builder: (context, state) => const CreateNewPasswordScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
  );
}
