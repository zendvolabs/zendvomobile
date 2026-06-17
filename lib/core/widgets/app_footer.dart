import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';

/// Shared footer widget shown across auth screens.
///
/// Displays "Help · Terms & Conditions · Privacy Policy" links.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 12,
      color: AppColors.getBodyTextColor(context).withValues(alpha: 0.5),
    );

    final separatorStyle = TextStyle(
      fontSize: 12,
      color: AppColors.getBodyTextColor(context).withValues(alpha: 0.3),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // TODO: Open help
          },
          child: Text(AppStrings.help, style: textStyle),
        ),
        Text('  ·  ', style: separatorStyle),
        GestureDetector(
          onTap: () {
            // TODO: Open terms
          },
          child: Text(AppStrings.terms, style: textStyle),
        ),
        Text('  ·  ', style: separatorStyle),
        GestureDetector(
          onTap: () {
            // TODO: Open privacy policy
          },
          child: Text(AppStrings.privacy, style: textStyle),
        ),
      ],
    );
  }
}
