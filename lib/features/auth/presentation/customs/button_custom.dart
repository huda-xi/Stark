import 'package:flutter/material.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.title, required this.onpressed});
  final String title;
  final  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onpressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: AppTextStyles.style14SemiBold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
