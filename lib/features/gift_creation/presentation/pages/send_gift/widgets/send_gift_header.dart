import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';

class SendGiftHeader extends StatelessWidget {
  const SendGiftHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.sendAGiftTitle,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.sendAGiftSubtitle,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.getBodyTextColor(context).withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
