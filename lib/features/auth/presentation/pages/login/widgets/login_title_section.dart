import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';

class LoginTitleSection extends StatelessWidget {
  const LoginTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.loginTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextHeading,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.loginSubtitle,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.lightTextBody.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
