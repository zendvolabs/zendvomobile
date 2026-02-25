import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';

import 'send_gift/widgets/amount_section.dart';
import 'send_gift/widgets/message_section.dart';
import 'send_gift/widgets/options_section.dart';
import 'send_gift/widgets/recipient_section.dart';
import 'send_gift/widgets/send_gift_app_bar.dart';
import 'send_gift/widgets/send_gift_bottom_bar.dart';
import 'send_gift/widgets/send_gift_header.dart';
import 'send_gift/widgets/unlock_date_time_section.dart';

/// "Send a Gift" screen.
///
/// Provides the BLoC and composes all form sections.
/// Navigation into this screen should wrap it with [BlocProvider]:
///
/// ```dart
/// BlocProvider(
///   create: (_) => GiftCreationBloc(),
///   child: const SendGiftPage(),
/// )
/// ```
class SendGiftPage extends StatelessWidget {
  const SendGiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GiftCreationBloc(),
      child: const _SendGiftView(),
    );
  }
}

class _SendGiftView extends StatefulWidget {
  const _SendGiftView();

  @override
  State<_SendGiftView> createState() => _SendGiftViewState();
}

class _SendGiftViewState extends State<_SendGiftView> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleStateChanges(BuildContext context, GiftCreationState state) {
    if (state is GiftCreationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gift sent! Code: ${state.giftCode}'),
          backgroundColor: AppColors.success,
        ),
      );
      // TODO: Navigate to success screen, e.g. context.go('/gift-success')
    } else if (state is GiftCreationError) {
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
    return BlocListener<GiftCreationBloc, GiftCreationState>(
      listener: _handleStateChanges,
      child: Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: const SendGiftAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSpacing.screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SendGiftHeader(),
                      const SizedBox(height: AppSpacing.l),
                      RecipientSection(phoneController: _phoneController),
                      const SizedBox(height: AppSpacing.l),
                      AmountSection(amountController: _amountController),
                      const SizedBox(height: AppSpacing.l),
                      const OptionsSection(),
                      const SizedBox(height: AppSpacing.l),
                      const UnlockDateTimeSection(),
                      const SizedBox(height: AppSpacing.l),
                      MessageSection(messageController: _messageController),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
              const SendGiftBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
