import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/utils/size_config.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/auth/presentation/bloc/create_new_password/create_new_password_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/create_new_password/create_new_password_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/create_new_password/create_new_password_state.dart';
import 'package:zendvo/features/auth/presentation/pages/login/widgets/login_footer.dart';
import 'package:zendvo/features/auth/presentation/pages/login/widgets/login_header.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateNewPasswordBloc(),
      child: const _CreateNewPasswordView(),
    );
  }
}

class _CreateNewPasswordView extends StatelessWidget {
  const _CreateNewPasswordView();

  void _handleStateChanges(
    BuildContext context,
    CreateNewPasswordState state,
  ) {
    if (state is CreateNewPasswordSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password created successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.go('/login');
    } else if (state is CreateNewPasswordError) {
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
        child: BlocListener<CreateNewPasswordBloc, CreateNewPasswordState>(
          listener: _handleStateChanges,
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.getHeight(2)),
                const LoginHeader(),
                SizedBox(height: SizeConfig.getHeight(4)),
                _TitleSection(),
                SizedBox(height: SizeConfig.getHeight(4)),
                const _PasswordForm(),
                SizedBox(height: SizeConfig.getHeight(4)),
                BlocBuilder<CreateNewPasswordBloc, CreateNewPasswordState>(
                  builder: (context, state) {
                    final isValid =
                        state is CreateNewPasswordFormState &&
                        state.isFormValid;
                    return AppButton(
                      text: AppStrings.createNewPasswordButton,
                      isLoading: state is CreateNewPasswordLoading,
                      onPressed: isValid
                          ? () => context
                              .read<CreateNewPasswordBloc>()
                              .add(CreateNewPasswordSubmitted())
                          : null,
                    );
                  },
                ),
                SizedBox(height: SizeConfig.getHeight(3)),
                const LoginFooter(),
                SizedBox(height: SizeConfig.getHeight(2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.createNewPasswordTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextHeading,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.createNewPasswordSubtitle,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.lightTextBody.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _PasswordForm extends StatefulWidget {
  const _PasswordForm();

  @override
  State<_PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<_PasswordForm> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: AppStrings.enterNewPasswordLabel,
          isPassword: true,
          controller: _passwordController,
          onChanged: (value) =>
              context.read<CreateNewPasswordBloc>().add(PasswordChanged(value)),
        ),
        SizedBox(height: SizeConfig.getHeight(1.5)),
        const _PasswordRequirements(),
        SizedBox(height: SizeConfig.getHeight(3)),
        AppTextField(
          label: AppStrings.confirmPasswordLabel,
          isPassword: true,
          controller: _confirmController,
          onChanged: (value) => context
              .read<CreateNewPasswordBloc>()
              .add(ConfirmPasswordChanged(value)),
        ),
      ],
    );
  }
}

class _PasswordRequirements extends StatelessWidget {
  const _PasswordRequirements();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewPasswordBloc, CreateNewPasswordState>(
      builder: (context, state) {
        final password =
            state is CreateNewPasswordFormState ? state.password : '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RequirementRow(
              label: 'At least 8 characters',
              met: password.length >= 8,
            ),
            _RequirementRow(
              label: 'One uppercase letter',
              met: password.contains(RegExp(r'[A-Z]')),
            ),
            _RequirementRow(
              label: 'One lowercase letter',
              met: password.contains(RegExp(r'[a-z]')),
            ),
            _RequirementRow(
              label: 'One number',
              met: password.contains(RegExp(r'\d')),
            ),
            _RequirementRow(
              label: 'One special character',
              met: password.contains(
                RegExp(r'[!@#\$&*~%^()\-_=+\[\]{}|;:,.<>?]'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final String label;
  final bool met;

  const _RequirementRow({required this.label, required this.met});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: met ? AppColors.success : AppColors.lightTextBody,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: met ? AppColors.success : AppColors.lightTextBody,
            ),
          ),
        ],
      ),
    );
  }
}
