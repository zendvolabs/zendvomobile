// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';

/// A single horizontal row in the review summary card.
///
/// [label] is left-aligned and muted.
/// [value] is right-aligned and uses the heading colour.
/// [valueStyle] overrides the default value text style when provided.
/// [isMultiLine] set to true lets the value wrap on a second line below the label
/// (used for the message field).
class ReviewRowItem extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;
  final bool isMultiLine;
  final bool showDivider;

  const ReviewRowItem({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
    this.isMultiLine = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.getBodyTextColor(context).withOpacity(0.6),
    );

    final defaultValueStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.getHeadingTextColor(context),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMultiLine) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: labelStyle),
                const SizedBox(height: 4),
                Text(value, style: valueStyle ?? defaultValueStyle),
              ],
            ),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(label, style: labelStyle)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: valueStyle ?? defaultValueStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.getInactiveBorderColor(context),
          ),
      ],
    );
  }
}
