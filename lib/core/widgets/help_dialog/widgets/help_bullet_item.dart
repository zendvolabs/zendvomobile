import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

class HelpBulletItem extends StatelessWidget {
  final String text;

  const HelpBulletItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final parts = text.split('–');
    final String mainPart = parts.isNotEmpty ? parts[0].trim() : text;
    final String subPart = parts.length > 1 ? parts[1].trim() : '';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 4.0),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.getBodyTextColor(context),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: AppColors.getBodyTextColor(context),
                ),
                children: [
                  TextSpan(
                    text: mainPart,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (subPart.isNotEmpty) TextSpan(text: ' \u2013 $subPart'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
