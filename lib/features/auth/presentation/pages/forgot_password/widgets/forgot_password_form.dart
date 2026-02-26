import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        final formState = state is ForgotPasswordFormState
            ? state
            : const ForgotPasswordFormState();

        final isLoading = state is ForgotPasswordLoading;

        return Column(
          children: [
            AppTextField(
              label: AppStrings.emailAddressLabel,
              hintText: AppStrings.emailAddressPlaceholder,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordEmailChanged(val),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              text: AppStrings.continueButton,
              isLoading: isLoading,
              onPressed: formState.isFormValid
                  ? () {
                      FocusScope.of(context).unfocus();
                      context.read<ForgotPasswordBloc>().add(
                        ForgotPasswordSubmitted(),
                      );
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
