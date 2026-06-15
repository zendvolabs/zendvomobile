// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

/// A country-code picker + phone number input field.
///
/// Displays a flag + code dropdown on the left and a phone
/// number text field on the right, matching the design spec.
class PhoneInputField extends StatelessWidget {
  final String label;
  final String countryCode;
  final String flagEmoji;
  final TextEditingController phoneController;
  final String hintText;
  final Widget? suffixIcon;
  final VoidCallback? onCountryCodeTap;
  final ValueChanged<String>? onPhoneChanged;

  const PhoneInputField({
    super.key,
    required this.label,
    required this.phoneController,
    this.countryCode = '+234',
    this.flagEmoji = '🇳🇬',
    this.hintText = '81 123 456 78',
    this.suffixIcon,
    this.onCountryCodeTap,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.getBodyTextColor(context).withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onCountryCodeTap,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightInactiveBorder),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  color: AppColors.lightBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(flagEmoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 4),
                    Text(
                      countryCode,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightTextHeading,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: AppColors.lightTextBody,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: SizedBox(
                height: 56,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: onPhoneChanged,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextHeading,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: AppColors.lightTextBody.withOpacity(0.4),
                      fontSize: 15,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 0,
                    ),
                    suffixIcon: suffixIcon,
                    filled: true,
                    fillColor: AppColors.lightBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.lightInactiveBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.lightInactiveBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.activeBorder,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
