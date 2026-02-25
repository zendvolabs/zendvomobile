import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';

class SendGiftBottomBar extends StatelessWidget {
  const SendGiftBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCreationBloc, GiftCreationState>(
      buildWhen: (previous, current) {
        final prevLoading = previous is GiftCreationLoading;
        final currLoading = current is GiftCreationLoading;
        return prevLoading != currLoading;
      },
      builder: (context, state) {
        final isLoading = state is GiftCreationLoading;

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
            text: AppStrings.continueButton,
            isLoading: isLoading,
            onPressed: () {
              context.read<GiftCreationBloc>().add(const GiftSubmitted());
            },
          ),
        );
      },
    );
  }
}
