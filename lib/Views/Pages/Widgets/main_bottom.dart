import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainBottom extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color forgroundColor;
  final String? text;
  final VoidCallback? onTap;
  final bool isloading;

  MainBottom({
    super.key,
    this.text,
    this.onTap,
    this.height = 60,
    this.width = double.infinity,
    this.backgroundColor = AppColors.primary,
    this.forgroundColor = AppColors.white,
    this.isloading = false,
  }) {
    assert(text != null || isloading == true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,

      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: forgroundColor,
        ),
        child: isloading
            ? Center(child: CircularProgressIndicator.adaptive())
            : Text(text!),
      ),
    );
  }
}
