import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';

/// Zendvo branding header for the verify email screen.
class VerifyEmailHeader extends StatelessWidget {
  const VerifyEmailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.vignette, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "Zendvo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextHeading,
          ),
        ),
      ],
    );
  }
}
