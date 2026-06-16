import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/help_dialog/help_dialog.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_state.dart';

/// Bottom action section with verify/create account button and help link.
class VerifyEmailActions extends StatelessWidget {
  /// The flow context determines the button label:
  /// - 'register' → "Create Account"
  /// - 'forgot-password' → "Verify"
  final String flow;

  const VerifyEmailActions({super.key, required this.flow});

  @override
  Widget build(BuildContext context) {
    final buttonText = flow == 'register'
        ? AppStrings.createAccountButton
        : AppStrings.verifyButton;

    return Column(
      children: [
        BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
          builder: (context, state) {
            final isComplete = state is VerifyEmailFormState &&
                state.isOtpComplete;
            return AppButton(
              text: buttonText,
              isLoading: state is VerifyEmailLoading,
              onPressed: isComplete && state is! VerifyEmailLoading
                  ? () {
                      context
                          .read<VerifyEmailBloc>()
                          .add(VerifyEmailSubmitted());
                    }
                  : null,
            );
          },
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => HelpDialog.show(context),
          child: Text(
            AppStrings.lowEmailAction,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
