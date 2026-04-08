import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "privacyTerms".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              "privacyPolicy".tr(),
              "privacyContent".tr(),
            ),
            SizedBox(height: 24.h),
            _buildSection(
              context,
              "termsOfService".tr(),
              "termsContent".tr(),
            ),
            SizedBox(height: 24.h),
            _buildSection(
              context,
              "returnPolicy".tr(),
              "returnContent".tr(),
            ),
            SizedBox(height: 24.h),
            _buildSection(
              context,
              "contactUs".tr(),
              "privacyContactContent".tr(),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 14.sp,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
