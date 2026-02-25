import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/pages/send_gift/widgets/send_gift_app_bar.dart';

import 'widgets/image_upload_widget.dart';
import 'widgets/sender_bottom_bar.dart';
import 'widgets/sender_details_header.dart';
import 'widgets/sender_form_section.dart';

/// "Sender Details" screen.
///
/// Should be pushed into the navigation stack with an existing
/// [GiftCreationBloc] provided if you want to retain the same flow.
///
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (_) => BlocProvider.value(
///       value: context.read<GiftCreationBloc>(),
///       child: const SenderDetailsPage(),
///     ),
///   ),
/// );
/// ```
class SenderDetailsPage extends StatefulWidget {
  const SenderDetailsPage({super.key});

  @override
  State<SenderDetailsPage> createState() => _SenderDetailsPageState();
}

class _SenderDetailsPageState extends State<SenderDetailsPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const SenderDetailsHeader(),
                    const SizedBox(height: AppSpacing.l),
                    ImageUploadWidget(
                      onTap: () {
                        // TODO: Implement image picker logic.
                        // Once an image is picked, dispatch:
                        // context.read<GiftCreationBloc>().add(SenderImageChanged(imagePath));
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SenderFormSection(
                      nameController: _nameController,
                      emailController: _emailController,
                      confirmEmailController: _confirmEmailController,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            SenderBottomBar(
              onPressed: () {
                // TODO: Validate the form fields and advance to the next screen (e.g. Review).
              },
            ),
          ],
        ),
      ),
    );
  }
}
