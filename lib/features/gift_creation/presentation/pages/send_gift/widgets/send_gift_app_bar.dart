import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';

class SendGiftAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SendGiftAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.getBackgroundColor(context),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Send a Gift',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextHeading,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.vignette, color: Colors.white, size: 20),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.lightTextHeading),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
