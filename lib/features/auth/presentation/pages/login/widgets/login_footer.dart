import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AppStrings.notRegisteredYet,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.lightTextBody,
            fontFamily: 'BR Firma',
          ),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  context.push('/register');
                },
                child: const Text(
                  AppStrings.signUp,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
