
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';

class OtpTextfeildCustom extends StatelessWidget {
  const OtpTextfeildCustom({
    super.key,
    required this.first,
    required this.last,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
  });

  final bool first;
  final bool last;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.otp,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 7.4,
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          keyboardType: TextInputType.number,
          textInputAction: last
              ? TextInputAction.done
              : TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: AppTextStyles.style22Medium,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (last) {
                FocusScope.of(context).unfocus();
              } else {
                nextFocusNode?.requestFocus();
              }
            } else if (!first) {
              previousFocusNode?.requestFocus();
            }

            onChanged?.call(value);
          },
        ),
      ),
    );
  }
}
