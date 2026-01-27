import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/features/auth/presentation/pages/email_verification_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/email-verification',
    routes: [
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
