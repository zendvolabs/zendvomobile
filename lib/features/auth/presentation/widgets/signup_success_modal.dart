// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';

/// Signup success confirmation modal.
///
/// Shown after a user successfully registers. Presents a celebratory
/// party-popper icon, success title/description, and a CTA button
/// that navigates to the dashboard.
///
/// Usage:
/// ```dart
/// SignupSuccessModal.show(context);
/// ```
class SignupSuccessModal extends StatelessWidget {
  const SignupSuccessModal({super.key});

  /// Convenience method to display the modal as a dialog overlay.
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SignupSuccessModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.l),
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(AppSpacing.xl),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color:
                        AppColors.getBodyTextColor(context).withOpacity(0.6),
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s),

            // Divider
            Divider(
              color:
                  AppColors.getInactiveBorderColor(context).withOpacity(0.5),
              thickness: 1,
              height: 1,
            ),

            const SizedBox(height: AppSpacing.xl),

            // Party popper icon in purple circle
            _buildCelebrationIcon(),

            const SizedBox(height: AppSpacing.xl),

            // Title
            Text(
              AppStrings.signupSuccessTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.getHeadingTextColor(context),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.s),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: Text(
                AppStrings.signupSuccessDescription,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.getBodyTextColor(context),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // CTA button
            AppButton(
              text: AppStrings.signupSuccessCta,
              onPressed: () {
                Navigator.pop(context); // dismiss modal
                context.go('/dashboard'); // navigate to dashboard
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the purple circle containing the party popper emoji,
  /// matching the Figma design (66×66 circle with 8px primaryLight border).
  Widget _buildCelebrationIcon() {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryLight,
          width: 8,
        ),
      ),
      child: const Center(
        child: Text('🎉', style: TextStyle(fontSize: 28)),
      ),
    );
  }
}
