import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/utils/size_config.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/login/login_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/login/login_state.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import 'widgets/login_title_section.dart';

/// Login screen for user authentication.
///
/// Wraps the internal widgets with the [LoginBloc].
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  void _handleStateChanges(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      // TODO: Navigate to home/dashboard screen
      // Example: context.go('/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: AppColors.success,
        ),
      );
    } else if (state is LoginError) {
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
        child: BlocListener<LoginBloc, LoginState>(
          listener: _handleStateChanges,
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.getHeight(2)),
                const LoginHeader(),
                SizedBox(height: SizeConfig.getHeight(4)),
                const LoginTitleSection(),
                SizedBox(height: SizeConfig.getHeight(4)),
                const LoginForm(),
                SizedBox(height: SizeConfig.getHeight(4)),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    final isValid = state is LoginFormState && state.isFormValid;
                    return AppButton(
                      text: AppStrings.loginButton,
                      isLoading: state is LoginLoading,
                      onPressed: isValid && state is! LoginLoading
                          ? () {
                              // Form validation is handled by BLoC state
                              context.read<LoginBloc>().add(LoginSubmitted());
                            }
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
