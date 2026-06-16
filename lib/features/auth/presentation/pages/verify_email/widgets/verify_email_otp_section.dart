import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_state.dart';
import 'package:zendvo/features/auth/presentation/widgets/otp_input_widget.dart';

/// OTP input section with resend countdown timer.
class VerifyEmailOtpSection extends StatelessWidget {
  const VerifyEmailOtpSection({super.key});

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
      builder: (context, state) {
        final formState = state is VerifyEmailFormState
            ? state
            : const VerifyEmailFormState();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OtpInputWidget(
              length: 6,
              hasError: formState.hasError,
              onCompleted: (otp) {
                context
                    .read<VerifyEmailBloc>()
                    .add(VerifyEmailOtpChanged(otp));
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: formState.canResend
                  ? () {
                      context
                          .read<VerifyEmailBloc>()
                          .add(VerifyEmailResendOtp());
                    }
                  : null,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: formState.canResend
                        ? AppColors.primary
                        : AppColors.getBodyTextColor(context),
                    fontFamily: 'BR Firma',
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.resendCode,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: formState.canResend
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    if (!formState.canResend)
                      TextSpan(
                        text: _formatTime(formState.secondsRemaining),
                        style: TextStyle(
                          color: AppColors.getBodyTextColor(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
