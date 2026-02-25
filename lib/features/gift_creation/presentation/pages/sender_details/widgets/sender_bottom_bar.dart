import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';

class SenderBottomBar extends StatelessWidget {
  final VoidCallback onPressed;

  const SenderBottomBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCreationBloc, GiftCreationState>(
      buildWhen: (previous, current) {
        if (previous is! GiftCreationFormState ||
            current is! GiftCreationFormState) {
          return true;
        }
        return previous.amount != current.amount;
      },
      builder: (context, state) {
        final formState = state is GiftCreationFormState
            ? state
            : const GiftCreationFormState();

        final amountText = formState.amount != null
            ? '${formState.amount!.toInt()}'
            : '0';

        return Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.m,
            AppSpacing.s,
            AppSpacing.m,
            AppSpacing.m,
          ),
          decoration: BoxDecoration(
            color: AppColors.getBackgroundColor(context),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: AppButton(
            text: '${AppStrings.giftButtonPrefix}\$$amountText',
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
