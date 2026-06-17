import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';

/// Reusable branding header for authentication screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        Text(
          "Zendvo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
      ],
    );
  }
}
