import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'help_bullet_item.dart';

class HelpDialogContent extends StatelessWidget {
  const HelpDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HelpBulletItem(text: AppStrings.helpBullet1),
        HelpBulletItem(text: AppStrings.helpBullet2),
        HelpBulletItem(text: AppStrings.helpBullet3),
        HelpBulletItem(text: AppStrings.helpBullet4),
        SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
