import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';

class SenderFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController confirmEmailController;

  const SenderFormSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.confirmEmailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabeledField(
          context,
          label: AppStrings.fullNameLabel,
          hint: AppStrings.fullNamePlaceholder,
          controller: nameController,
          onChanged: (val) =>
              context.read<GiftCreationBloc>().add(SenderNameChanged(val)),
        ),
        const SizedBox(height: AppSpacing.l),
        _buildLabeledField(
          context,
          label: AppStrings.emailAddressLabel,
          hint: AppStrings.emailAddressPlaceholder,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (val) =>
              context.read<GiftCreationBloc>().add(SenderEmailChanged(val)),
        ),
        const SizedBox(height: AppSpacing.l),
        _buildLabeledField(
          context,
          label: AppStrings.confirmEmailAddressLabel,
          hint: AppStrings.emailAddressPlaceholder,
          controller: confirmEmailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (val) => context.read<GiftCreationBloc>().add(
            SenderConfirmEmailChanged(val),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return AppTextField(
      label: label,
      hintText: hint,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
