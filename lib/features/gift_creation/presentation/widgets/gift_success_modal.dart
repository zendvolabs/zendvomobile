import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';

class GiftSuccessModal extends StatelessWidget {
  final String recipientName;
  final VoidCallback onClose;

  const GiftSuccessModal({
    super.key,
    required this.recipientName,
    required this.onClose,
  });

  static void show(
    BuildContext context, {
    required String recipientName,
    required VoidCallback onClose,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          GiftSuccessModal(recipientName: recipientName, onClose: onClose),
    );
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.modalName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getHeadingTextColor(context),
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.lightTextBody,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            Divider(color: AppColors.getInactiveBorderColor(context)),
            const SizedBox(height: AppSpacing.xl),

            _buildSuccessIcon(),

            const SizedBox(height: AppSpacing.xl),

            Text(
              AppStrings.giftSentSuccessfully,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.getHeadingTextColor(context),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.s),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.getBodyTextColor(context),
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: '• '),
                    const TextSpan(text: AppStrings.giftSentSubtitlePrefix),
                    TextSpan(
                      text: recipientName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: AppStrings.giftSentSubtitleSuffix),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            AppButton(text: AppStrings.close, onPressed: onClose),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
          ),
          ...List.generate(8, (index) {
            final angle = (index * 45) * 3.14159 / 180;
            return Transform.translate(
              offset: Offset(40 * math.cos(angle), 40 * math.sin(angle)),
              child: Container(
                width: index % 2 == 0 ? 4 : 3,
                height: index % 2 == 0 ? 4 : 3,
                decoration: BoxDecoration(
                  color: index % 3 == 0
                      ? AppColors.success
                      : AppColors.success.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}
