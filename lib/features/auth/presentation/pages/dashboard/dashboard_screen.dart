import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

/// Placeholder dashboard screen.
///
/// Serves as the navigation destination after successful signup.
/// This will be replaced with the full dashboard implementation.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Zendvo branding
              Text(
                'Zendvo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const Spacer(),

              // Welcome message
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('🎁', style: TextStyle(fontSize: 36)),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.l),
                    Text(
                      'Welcome to Zendvo!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.getHeadingTextColor(context),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      'Your dashboard is being built.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.getBodyTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
