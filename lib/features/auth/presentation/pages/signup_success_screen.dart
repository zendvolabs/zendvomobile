import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/features/auth/presentation/widgets/signup_success_dialog.dart';

/// SignupSuccessScreen displays the signup success dialog modal
/// after successful email verification.
///
/// This screen shows a modal dialog with:
/// - Success confirmation message
/// - Celebration emoji icon
/// - Action button to proceed to dashboard
/// - Close button for dismissal
/// - Smooth animations and responsive design
class SignupSuccessScreen extends StatefulWidget {
  /// Optional callback when user proceeds to dashboard
  final VoidCallback? onProceedToDashboard;

  /// Optional callback when dialog is dismissed
  final VoidCallback? onDismiss;

  const SignupSuccessScreen({
    super.key,
    this.onProceedToDashboard,
    this.onDismiss,
  });

  @override
  State<SignupSuccessScreen> createState() => _SignupSuccessScreenState();
}

class _SignupSuccessScreenState extends State<SignupSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Show the dialog immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSignupSuccessDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Container(
        color: AppColors.lightBackground,
      ),
    );
  }

  /// Display the signup success dialog modal
  void _showSignupSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Force user interaction with buttons
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext context) {
        return SignupSuccessDialog(
          emoji: '🎉',
          allowBackdropDismiss: false,
          onDismiss: () {
            widget.onDismiss?.call();
            // Could navigate to another screen here
          },
          onProceedToDashboard: () {
            widget.onProceedToDashboard?.call();
            // Navigate to dashboard here
          },
        );
      },
    );
  }
}
