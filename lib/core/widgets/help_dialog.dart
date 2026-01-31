// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const HelpDialog());
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: AppColors.lightTextBody),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ), 
            const SizedBox(height: AppSpacing.m),
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.1),
                    width: 10,
                  ),
                ),
                child: const Center(
                  child: Text('🤔', style: TextStyle(fontSize: 40)),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            Center(
              child: Text(
                AppStrings.helpDialogTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getHeadingTextColor(context),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            _buildBulletPoint(context, AppStrings.helpBullet1),
            _buildBulletPoint(context, AppStrings.helpBullet2),
            _buildBulletPoint(context, AppStrings.helpBullet3),
            _buildBulletPoint(context, AppStrings.helpBullet4),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              text: AppStrings.close,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: AppColors.getBodyTextColor(context),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppColors.getBodyTextColor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
