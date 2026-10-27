import 'package:flutter/material.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';

class TextfeildCustom extends StatefulWidget {
  const TextfeildCustom({
    super.key,
    required this.text,
    required this.hint,
    this.suffixicon,
    this.controller,
    this.validator, 
    this.obscureText, this.onChanged,
  });
  final String text;
  final String hint;
  final Widget? suffixicon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Function(String)? onChanged;


  @override
  State<TextfeildCustom> createState() => _TextfeildCustomState();
}

class _TextfeildCustomState extends State<TextfeildCustom> {
  
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: AppTextStyles.style12SemiBold.copyWith(
            color: AppColors.textFeildGrey,
          ),
        ),

        TextFormField(
          obscureText: widget.obscureText??false,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: widget.suffixicon,

            // prefixIcon: Icon(prefixicon),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
