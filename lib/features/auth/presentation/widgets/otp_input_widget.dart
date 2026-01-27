import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

class OtpInputWidget extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final bool hasError;

  const OtpInputWidget({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.hasError = false,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _otpValues;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _otpValues = List.generate(widget.length, (index) => '');

    for (int i = 0; i < widget.length; i++) {
      _focusNodes[i].addListener(() {
        setState(() {}); // Rebuild for border color change
      });
    }

    // Auto focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste
      _handlePaste(value);
      return;
    }

    if (value.isNotEmpty) {
      _otpValues[index] = value;
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      // Handled in _onKeyEvent for backspace
      _otpValues[index] = '';
    }

    _checkCompletion();
  }

  void _handlePaste(String value) {
    String pastedText = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (pastedText.length > widget.length) {
      pastedText = pastedText.substring(0, widget.length);
    }

    for (int i = 0; i < pastedText.length; i++) {
      _controllers[i].text = pastedText[i];
      _otpValues[i] = pastedText[i];
    }

    if (pastedText.length < widget.length) {
      _focusNodes[pastedText.length].requestFocus();
    } else {
      _focusNodes[widget.length - 1].unfocus();
    }

    _checkCompletion();
    setState(() {});
  }

  void _checkCompletion() {
    String otp = _otpValues.join('');
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: 48,
          height: 48,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                if (_controllers[index].text.isEmpty && index > 0) {
                  _focusNodes[index - 1].requestFocus();
                  _controllers[index - 1].clear();
                  _otpValues[index - 1] = '';
                }
              }
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.getHeadingTextColor(context),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: AppColors.getFieldBackgroundColor(context),
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  borderSide: BorderSide(
                    color: widget.hasError
                        ? AppColors.error
                        : AppColors.getInactiveBorderColor(context),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  borderSide: BorderSide(
                    color: widget.hasError
                        ? AppColors.error
                        : AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && _controllers[index].text.length > 1) {
                  _controllers[index].text = value.characters.last;
                }
                _onChanged(index, _controllers[index].text);
              },
              onTap: () {
                _controllers[index].selection = TextSelection.fromPosition(
                  TextPosition(offset: _controllers[index].text.length),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
