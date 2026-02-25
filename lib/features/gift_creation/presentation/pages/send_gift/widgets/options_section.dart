import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/gift_option_checkbox.dart';

class OptionsSection extends StatelessWidget {
  const OptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCreationBloc, GiftCreationState>(
      buildWhen: (previous, current) {
        if (previous is! GiftCreationFormState ||
            current is! GiftCreationFormState) {
          return true;
        }
        return previous.hideAmount != current.hideAmount ||
            previous.stayAnonymous != current.stayAnonymous;
      },
      builder: (context, state) {
        final formState = state is GiftCreationFormState
            ? state
            : const GiftCreationFormState();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GiftOptionCheckbox(
              label: AppStrings.hideAmountLabel,
              value: formState.hideAmount,
              onChanged: (val) =>
                  context.read<GiftCreationBloc>().add(HideAmountToggled(val)),
            ),
            const SizedBox(height: AppSpacing.m),
            GiftOptionCheckbox(
              label: AppStrings.stayAnonymousLabel,
              value: formState.stayAnonymous,
              onChanged: (val) => context.read<GiftCreationBloc>().add(
                StayAnonymousToggled(val),
              ),
            ),
          ],
        );
      },
    );
  }
}
