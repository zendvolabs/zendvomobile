import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/utils/size_config.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:zendvo/features/auth/presentation/widgets/auth_header.dart';

/// Screen allowing users to request a password reset code.
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

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleStateChanges(BuildContext context, ForgotPasswordState state) {
    if (state is ForgotPasswordSuccess) {
      context.go('/verify-email');
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
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.getHeadingTextColor(context),
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: _handleStateChanges,
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.getHeight(2)),
                const AuthHeader(),
                SizedBox(height: SizeConfig.getHeight(4)),
                Text(
                  AppStrings.forgotPasswordTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getHeadingTextColor(context),
                  ),
                ),
                SizedBox(height: SizeConfig.getHeight(1.5)),
                Text(
                  AppStrings.forgotPasswordSubtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.getBodyTextColor(context).withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: SizeConfig.getHeight(4)),
                AppTextField(
                  label: AppStrings.emailAddressLabel,
                  hintText: AppStrings.emailAddressPlaceholder,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(ForgotPasswordEmailChanged(value));
                  },
                ),
                SizedBox(height: SizeConfig.getHeight(4)),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    final isFormValid =
                        state is ForgotPasswordFormState && state.isEmailValid;
                    final isLoading = state is ForgotPasswordLoading;

                    return AppButton(
                      text: AppStrings.continueButton,
                      isLoading: isLoading,
                      onPressed: isFormValid && !isLoading
                          ? () {
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(ForgotPasswordSubmitted());
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
