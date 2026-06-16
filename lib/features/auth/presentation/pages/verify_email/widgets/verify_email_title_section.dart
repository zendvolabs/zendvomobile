import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';

/// Title section for the verify email screen.
///
/// Displays the title and a subtitle with the user's masked email address.
class VerifyEmailTitleSection extends StatelessWidget {
  final String maskedEmail;

  const VerifyEmailTitleSection({super.key, required this.maskedEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.verifyEmailTitle,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: AppColors.getBodyTextColor(context),
              height: 1.5,
              fontFamily: 'BR Firma',
            ),
            children: [
              const TextSpan(text: AppStrings.verifyEmailSubtitle),
              TextSpan(
                text: maskedEmail,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
