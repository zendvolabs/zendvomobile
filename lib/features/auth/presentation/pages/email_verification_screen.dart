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
                  ),
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.getHeight(2)),
                        _buildHeader(),
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
                              state.status == EmailVerificationStatus.failure,
                        ),
                        SizedBox(height: SizeConfig.getHeight(3)),
                        _buildTimerRow(context, state),
                        const Spacer(),
                        _buildActionButtons(context, state),
                        SizedBox(height: SizeConfig.getHeight(2)),
                        _buildFooter(context),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.vignette, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "Zendvo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBackground,
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
            fontSize: 12,
            color: AppColors.getHeadingTextColor(context),
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

    return Center(
      child: GestureDetector(
        onTap: state.canResend
            ? () {
                context.read<EmailVerificationBloc>().add(
                  const ResendOTPEvent(),
                );
              }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.resendCode,
              style: TextStyle(
                fontSize: 16,
                color: state.canResend
                    ? AppColors.primary
                    : AppColors.getBodyTextColor(context),
                fontWeight: state.canResend
                    ? FontWeight.bold
                    : FontWeight.normal,
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
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    EmailVerificationState state,
  ) {
    return Column(
      children: [
        AppButton(
          height: 48,
          text: AppStrings.verifyButton,
          onPressed: () {},
          isLoading: state.status == EmailVerificationStatus.loading,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: state.canResend
              ? () {
                  context.read<EmailVerificationBloc>().add(
                    const ResendOTPEvent(),
                  );
                }
              : null,
          child: Text(
            AppStrings.lowEmailAction,
            style: TextStyle(
              color: state.canResend ? AppColors.primary : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _footerLink(context, AppStrings.help),
        _footerDivider(context),
        _footerLink(context, AppStrings.terms),
        _footerDivider(context),
        _footerLink(context, AppStrings.privacy),
      ],
    );
  }

  Widget _footerLink(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: AppColors.getBodyTextColor(context).withOpacity(0.6),
      ),
    );
  }

  Widget _footerDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        "|",
        style: TextStyle(
          fontSize: 12,
          color: AppColors.getBodyTextColor(context).withOpacity(0.4),
        ),
      ),
    );
  }
}
