import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/quick_amount_selector.dart';
import 'section_label.dart';

class AmountSection extends StatelessWidget {
  final TextEditingController amountController;

  const AmountSection({super.key, required this.amountController});

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(label: AppStrings.enterAmountLabel),
            const SizedBox(height: 8),
            AppTextField(
              hintText: AppStrings.amountHint,
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              prefix: const Padding(
                padding: EdgeInsets.only(left: 14, right: 8),
                child: Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightTextHeading,
                  ),
                ),
              ),
              onChanged: (val) {
                final parsed = double.tryParse(val);
                if (parsed != null) {
                  context.read<GiftCreationBloc>().add(AmountChanged(parsed));
                }
              },
            ),
            const SizedBox(height: AppSpacing.m),
            QuickAmountSelector(
              selectedAmount: formState.amount,
              onAmountSelected: (amount) {
                amountController.text = amount.toInt().toString();
                context.read<GiftCreationBloc>().add(
                  QuickAmountSelected(amount),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
