import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/phone_input_field.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/recipient_card.dart';

class RecipientSection extends StatelessWidget {
  final TextEditingController phoneController;

  const RecipientSection({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCreationBloc, GiftCreationState>(
      buildWhen: (previous, current) {
        if (previous is! GiftCreationFormState ||
            current is! GiftCreationFormState) {
          return true;
        }
        return previous.countryCode != current.countryCode ||
            previous.isLookingUpRecipient != current.isLookingUpRecipient ||
            previous.recipient != current.recipient;
      },
      builder: (context, state) {
        final formState = state is GiftCreationFormState
            ? state
            : const GiftCreationFormState();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhoneInputField(
              label: AppStrings.recipientNoLabel,
              phoneController: phoneController,
              countryCode: formState.countryCode,
              hintText: AppStrings.phoneNumberPlaceholder,
              onPhoneChanged: (val) {
                context.read<GiftCreationBloc>().add(
                  RecipientPhoneChanged(val),
                );
              },
              suffixIcon: _buildSearchSuffix(context, formState),
            ),
            if (formState.isLookingUpRecipient) ...[
              const SizedBox(height: AppSpacing.s),
              const _RecipientLoadingShimmer(),
            ] else if (formState.recipient != null) ...[
              const SizedBox(height: AppSpacing.s),
              RecipientCard(recipient: formState.recipient!),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSearchSuffix(BuildContext context, GiftCreationFormState form) {
    if (form.isLookingUpRecipient) {
      return const Padding(
        padding: EdgeInsets.all(14),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      );
    }
    return IconButton(
      icon: const Icon(
        Icons.autorenew_outlined,
        color: AppColors.primary,
        size: 22,
      ),
      onPressed: () {
        final phone = phoneController.text.trim();
        if (phone.isNotEmpty) {
          context.read<GiftCreationBloc>().add(
            RecipientLookupRequested(
              countryCode: form.countryCode,
              phone: phone,
            ),
          );
        }
      },
    );
  }
}

class _RecipientLoadingShimmer extends StatelessWidget {
  const _RecipientLoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightFieldBackground,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        border: Border.all(color: AppColors.lightInactiveBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.lightInactiveBorder,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.lightInactiveBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.lightInactiveBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
