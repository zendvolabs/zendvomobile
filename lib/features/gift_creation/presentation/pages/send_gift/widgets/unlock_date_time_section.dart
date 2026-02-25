import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/date_time_picker_field.dart';
import 'section_label.dart';

class UnlockDateTimeSection extends StatelessWidget {
  const UnlockDateTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCreationBloc, GiftCreationState>(
      buildWhen: (previous, current) {
        if (previous is! GiftCreationFormState ||
            current is! GiftCreationFormState) {
          return true;
        }
        return previous.unlockDate != current.unlockDate ||
            previous.unlockTime != current.unlockTime;
      },
      builder: (context, state) {
        final formState = state is GiftCreationFormState
            ? state
            : const GiftCreationFormState();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(label: AppStrings.selectUnlockDateLabel),
            const SizedBox(height: 8),
            DateTimePickerField(
              labelText: '',
              hintText: AppStrings.datePlaceholder,
              value: formState.unlockDate != null
                  ? _formatDate(formState.unlockDate!)
                  : null,
              trailingIcon: Icons.calendar_today_outlined,
              onTap: () => _pickDate(context),
            ),
            const SizedBox(height: AppSpacing.s),
            DateTimePickerField(
              labelText: '',
              hintText: AppStrings.timePlaceholder,
              value: formState.unlockTime,
              trailingIcon: Icons.access_time_outlined,
              onTap: () => _pickTime(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      context.read<GiftCreationBloc>().add(UnlockDateSelected(picked));
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      final formatted = picked.format(context);
      context.read<GiftCreationBloc>().add(UnlockTimeSelected(formatted));
    }
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year;
    return '$d.$m.$y';
  }
}
