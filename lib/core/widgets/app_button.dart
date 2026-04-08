import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  
  const AppButton({
    super.key,
    this.backgroundColor,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: backgroundColor != null 
              ? Border.all(color: theme.colorScheme.onSurface.withOpacity(0.1)) 
              : null,
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: backgroundColor == null ? Colors.white : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
