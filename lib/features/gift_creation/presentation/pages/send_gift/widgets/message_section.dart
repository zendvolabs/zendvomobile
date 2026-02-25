import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'section_label.dart';

class MessageSection extends StatelessWidget {
  final TextEditingController messageController;

  const MessageSection({super.key, required this.messageController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(label: AppStrings.messageLabel),
        const SizedBox(height: 8),
        AppTextField(
          hintText: AppStrings.messagePlaceholder,
          controller: messageController,
          onChanged: (val) =>
              context.read<GiftCreationBloc>().add(MessageChanged(val)),
        ),
      ],
    );
  }
}
