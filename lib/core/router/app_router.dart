import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/features/auth/presentation/pages/login/login_screen.dart';
import 'package:zendvo/features/auth/presentation/pages/create_new_password/create_new_password_screen.dart';

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
        path: '/create-new-password',
        name: 'create-new-password',
        builder: (context, state) => const CreateNewPasswordScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
  );
}
