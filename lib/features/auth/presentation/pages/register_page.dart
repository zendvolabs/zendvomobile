// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/utils/size_config.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.getHeight(2)),
                _buildHeader(),
                SizedBox(height: SizeConfig.getHeight(4)),
                _buildTitle(),
                SizedBox(height: SizeConfig.getHeight(4)),
                AppTextField(
                  label: AppStrings.fullNameLabel,
                  hintText: AppStrings.fullNamePlaceholder,
                  controller: _nameController,
                ),
                SizedBox(height: SizeConfig.getHeight(3)),
                _buildPhoneField(),
                SizedBox(height: SizeConfig.getHeight(3)),
                AppTextField(
                  label: AppStrings.emailAddressLabel,
                  hintText: AppStrings.emailAddressPlaceholder,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: SizeConfig.getHeight(3)),
                AppTextField(
                  label: AppStrings.passwordLabel,
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(height: SizeConfig.getHeight(1)),
                _buildPasswordHint(),
                SizedBox(height: SizeConfig.getHeight(3)),
                AppTextField(
                  label: AppStrings.confirmPasswordLabel,
                  isPassword: true,
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: SizeConfig.getHeight(4)),
                AppButton(
                  text: AppStrings.createAccountButton,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration
                    }
                  },
                ),
                SizedBox(height: SizeConfig.getHeight(3)),
                _buildLoginLink(),
                SizedBox(height: SizeConfig.getHeight(6)),
                _buildFooter(),
                SizedBox(height: SizeConfig.getHeight(2)),
              ],
            ),
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
            color: AppColors.lightTextHeading,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.createAccountTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextHeading,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.createAccountSubtitle,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.lightTextBody.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 110,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightInactiveBorder),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: const Row(
                children: [
                  _NigerianFlag(),
                  SizedBox(width: 8),
                  Text(
                    "+234",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightTextHeading,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppTextField(
                hintText: AppStrings.phoneNumberPlaceholder,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordHint() {
    return Text(
      AppStrings.passwordHint,
      style: TextStyle(
        fontSize: 12,
        color: AppColors.lightTextBody.withOpacity(0.6),
        height: 1.4,
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AppStrings.alreadyHaveAccount,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.lightTextBody,
            fontFamily: 'BR Firma',
          ),
          children: [
            TextSpan(
              text: AppStrings.logIn,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _footerLink(AppStrings.help),
        _footerDivider(),
        _footerLink(AppStrings.terms),
        _footerDivider(),
        _footerLink(AppStrings.privacy),
      ],
    );
  }

  Widget _footerLink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.lightTextBody.withOpacity(0.6),
      ),
    );
  }

  Widget _footerDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        "|",
        style: TextStyle(
          fontSize: 14,
          color: AppColors.lightTextBody.withOpacity(0.4),
        ),
      ),
    );
  }
}

class _NigerianFlag extends StatelessWidget {
  const _NigerianFlag();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 16,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: Row(
        children: [
          Expanded(child: Container(color: const Color(0xFF008751))),
          Expanded(child: Container(color: Colors.white)),
          Expanded(child: Container(color: const Color(0xFF008751))),
        ],
      ),
    );
  }
}
