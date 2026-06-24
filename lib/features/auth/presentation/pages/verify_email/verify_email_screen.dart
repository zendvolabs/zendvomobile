import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/utils/size_config.dart';
import 'package:zendvo/core/widgets/app_footer.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/verify_email/verify_email_state.dart';
import 'package:zendvo/features/auth/presentation/widgets/signup_success_modal.dart';
import 'widgets/verify_email_actions.dart';
import 'widgets/verify_email_header.dart';
import 'widgets/verify_email_otp_section.dart';
import 'widgets/verify_email_title_section.dart';

/// Email verification (OTP) screen.
///
/// Shared between the registration and forgot-password flows.
/// The [email] parameter is used to display the masked email.
/// The [flow] parameter ('register' or 'forgot-password') determines
/// button labels and post-verification navigation.
class VerifyEmailScreen extends StatelessWidget {
  final String email;
  final String flow;

  const VerifyEmailScreen({
    super.key,
    required this.email,
    required this.flow,
  });

  /// Masks an email like "john123@gmail.com" → "jo***3@gmail.com"
  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2 || parts[0].length < 3) return email;

    final name = parts[0];
    final masked =
        '${name.substring(0, 2)}***${name.substring(name.length - 1)}';
    return '$masked@${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyEmailBloc(),
      child: _VerifyEmailView(
        maskedEmail: _maskEmail(email),
        flow: flow,
      ),
    );
  }
}

class _VerifyEmailView extends StatelessWidget {
  final String maskedEmail;
  final String flow;

  const _VerifyEmailView({
    required this.maskedEmail,
    required this.flow,
  });

  void _handleStateChanges(BuildContext context, VerifyEmailState state) {
    if (state is VerifyEmailSuccess) {
      if (flow == 'register') {
        SignupSuccessModal.show(context);
      } else {
        context.push('/create-new-password');
      }
    } else if (state is VerifyEmailError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: BlocListener<VerifyEmailBloc, VerifyEmailState>(
          listener: _handleStateChanges,
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.getHeight(2)),
                const VerifyEmailHeader(),
                SizedBox(height: SizeConfig.getHeight(4)),
                VerifyEmailTitleSection(maskedEmail: maskedEmail),
                SizedBox(height: SizeConfig.getHeight(3)),
                const VerifyEmailOtpSection(),
                const Spacer(),
                VerifyEmailActions(flow: flow),
                SizedBox(height: SizeConfig.getHeight(2)),
                const AppFooter(),
                SizedBox(height: SizeConfig.getHeight(2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
