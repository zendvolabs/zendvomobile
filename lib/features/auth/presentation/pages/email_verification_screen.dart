// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/utils/size_config.dart';
import 'package:zendvo/features/auth/presentation/bloc/email_verification/email_verification_bloc.dart';
import 'package:zendvo/features/auth/presentation/widgets/otp_input_widget.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/help_dialog.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String email;

  const EmailVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => EmailVerificationBloc(),
      child: Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        body: SafeArea(
          child: BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == EmailVerificationStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Verification Successful!")),
                );
              } else if (state.status == EmailVerificationStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? "Verification Failed"),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: SizeConfig.getHeight(2)),
                            _buildLogo(),
                            SizedBox(height: SizeConfig.getHeight(5)),
                            _buildInstructionalText(context),
                            SizedBox(height: SizeConfig.getHeight(4)),
                            OtpInputWidget(
                              onCompleted: (otp) {
                                context.read<EmailVerificationBloc>().add(
                                  VerifyOTPEvent(otp),
                                );
                              },
                              hasError:
                                  state.status ==
                                  EmailVerificationStatus.failure,
                            ),
                            SizedBox(height: SizeConfig.getHeight(3)),
                            _buildTimerRow(context, state),
                          ],
                        ),
                      ),
                    ),
                    _buildActionButtons(context, state),
                    SizedBox(height: SizeConfig.getHeight(3)),
                    _buildFooterLinks(context),
                    SizedBox(height: SizeConfig.getHeight(2)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.vignette, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 8),
        const Text(
          'Zendvo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionalText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.verifyEmailTitle,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${AppStrings.verifyEmailSubtitle} $email",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.getBodyTextColor(context).withValues(alpha: 0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTimerRow(BuildContext context, EmailVerificationState state) {
    final minutes = (state.timerDuration / 60).floor().toString().padLeft(
      1,
      '0',
    );
    final seconds = (state.timerDuration % 60).floor().toString().padLeft(
      2,
      '0',
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: state.canResend
              ? () {
                  context.read<EmailVerificationBloc>().add(
                    const ResendOTPEvent(),
                  );
                }
              : null,
          child: Text(
            AppStrings.resendCode,
            style: TextStyle(
              fontSize: 14,
              color: state.canResend
                  ? AppColors.primary
                  : AppColors.getHeadingTextColor(context),
              fontWeight: state.canResend ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
        if (!state.canResend)
          Text(
            "$minutes:$seconds",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    EmailVerificationState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          height: AppSpacing.buttonHeight,
          text: AppStrings
              .createAccountButton, // Design shows 'Create Account' here
          isLoading: state.status == EmailVerificationStatus.loading,
          onPressed: () {
            // Trigger OTP verification from bloc if we needed a manual button tap
            // But usually OTP is verified auto on completion. If they tap this,
            // you might want to force verification or show an error if incomplete.
            // For now, let's keep it as is, or trigger verification if we had the state's OTP
          },
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            // Navigate or show help
            HelpDialog.show(context);
          },
          child: Text(
            AppStrings.lowEmailAction,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    final style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.getInactiveBorderColor(context),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => HelpDialog.show(context),
          child: Text(AppStrings.help, style: style),
        ),
        _buildDivider(context),
        GestureDetector(
          onTap: () {
            // TODO: Open Terms
          },
          child: Text(AppStrings.terms, style: style),
        ),
        _buildDivider(context),
        GestureDetector(
          onTap: () {
            // TODO: Open Privacy Policy
          },
          child: Text(AppStrings.privacy, style: style),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Text(
        '|',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.getInactiveBorderColor(context),
        ),
      ),
    );
  }
}
