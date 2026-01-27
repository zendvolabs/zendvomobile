import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/utils/size_config.dart';

/// Reusable SignupSuccessDialog widget displayed as a confirmation modal
/// after successful email verification.
///
/// Features:
/// - Rounded corners and white background
/// - Semi-transparent dark backdrop overlay
/// - Celebration emoji icon in purple circle
/// - Bold headline with success message
/// - Body text with proper spacing and formatting
/// - Close button (X) for dismissal
/// - Full-width primary "Proceed to dashboard" button
/// - Smooth fade-in and slide-up animations
/// - Safe area and responsive design support
class SignupSuccessDialog extends StatefulWidget {
  /// Callback when the dialog is dismissed or action button is tapped
  final VoidCallback? onDismiss;

  /// Callback when "Proceed to dashboard" button is tapped
  final VoidCallback? onProceedToDashboard;

  /// Whether to allow dismissal via backdrop tap
  final bool allowBackdropDismiss;

  /// Emoji/icon to display in the circle
  final String emoji;

  const SignupSuccessDialog({
    super.key,
    this.onDismiss,
    this.onProceedToDashboard,
    this.allowBackdropDismiss = false,
    this.emoji = '🎉',
  });

  @override
  State<SignupSuccessDialog> createState() => _SignupSuccessDialogState();
}

class _SignupSuccessDialogState extends State<SignupSuccessDialog>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Slide animation controller for celebration effect
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Fade animation from 0 to 1
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Slide animation from bottom to final position with ease
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Dialog(
          insetAnimationDuration: const Duration(milliseconds: 300),
          insetAnimationCurve: Curves.easeOut,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: GestureDetector(
            onTap: widget.allowBackdropDismiss
                ? () {
                    _dismissDialog();
                  }
                : null,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent dismiss when tapping the modal
                  child: _buildModalContent(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModalContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button (X) positioned at top-left
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: _dismissDialog,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: AppColors.lightTextBody,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.getHeight(2)),

                  // Emoji icon in purple circle
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.15),
                    ),
                    child: Center(
                      child: Text(
                        widget.emoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.getHeight(3)),

                  // Headline
                  Text(
                    AppStrings.signupSuccessTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightTextHeading,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.getHeight(2)),

                  // Body text
                  Text(
                    AppStrings.signupSuccessMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.lightTextBody,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.getHeight(4)),

                  // Proceed to dashboard button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _proceedToDashboard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppStrings.signupSuccessButton,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dismiss the dialog with optional callback
  void _dismissDialog() {
    Navigator.of(context).pop();
    widget.onDismiss?.call();
  }

  /// Proceed to dashboard with optional callback
  void _proceedToDashboard() {
    Navigator.of(context).pop();
    widget.onProceedToDashboard?.call();
  }
}
