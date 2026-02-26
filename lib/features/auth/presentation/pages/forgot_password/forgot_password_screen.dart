import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';

import 'widgets/forgot_password_form.dart';
import 'widgets/forgot_password_header.dart';

/// "Forgot Password" screen.
///
/// Wraps the internal widgets with the [ForgotPasswordBloc].
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatelessWidget {
  const _ForgotPasswordView();

  void _handleStateChanges(BuildContext context, ForgotPasswordState state) {
    if (state is ForgotPasswordSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset instructions sent!'),
          backgroundColor: AppColors.success,
        ),
      );
      // TODO: Navigate securely (e.g. context.go('/reset-success') or pop)
    } else if (state is ForgotPasswordError) {
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
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: _handleStateChanges,
      child: Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppColors.getHeadingTextColor(context),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.m),
                ForgotPasswordHeader(),
                SizedBox(height: AppSpacing.xxl),
                ForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
