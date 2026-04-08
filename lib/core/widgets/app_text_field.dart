import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 14.sp,
      ),
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.hintStyle.copyWith(
          color: isDark ? Colors.grey.shade500 : AppColors.darkGrayColor,
        ),
        filled: true,
        fillColor: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.2) : AppColors.grayColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}