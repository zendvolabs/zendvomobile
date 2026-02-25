import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final String label;

  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.getBodyTextColor(context).withValues(alpha: 0.6),
      ),
    );
  }
}
