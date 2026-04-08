import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/features/contact/cubit/contact_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "contactUs".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocListener<ContactCubit, ContactState>(
        listener: (context, state) {
          if (state is ContactLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is ContactSuccess) {
            Navigator.pop(context);
            _showSuccessDialog();
          } else if (state is ContactError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.headset_mic_outlined,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "getInTouch".tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "weLoveToHear".tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildLabel("fullName".tr(), theme),
              SizedBox(height: 8.h),
              AppTextField(
                controller: nameController,
                hintText: "fullName".tr(),
              ),
              SizedBox(height: 16.h),
              _buildLabel("email".tr(), theme),
              SizedBox(height: 8.h),
              AppTextField(
                controller: emailController,
                hintText: "email".tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              _buildLabel("subject".tr(), theme),
              SizedBox(height: 8.h),
              AppTextField(
                controller: subjectController,
                hintText: "subject".tr(),
              ),
              SizedBox(height: 16.h),
              _buildLabel("message".tr(), theme),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.1) : AppColors.grayColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: isDark ? Border.all(color: Colors.white12) : null,
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: 5,
                  style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "writeMessage".tr(),
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey.shade500 : AppColors.darkGrayColor,
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12.w),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              AppButton(
                text: "sendMessage".tr(),
                onPressed: _sendMessage,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface.withOpacity(0.8),
      ),
    );
  }

  void _sendMessage() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        subjectController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("fillFieldsError".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<ContactCubit>().sendMessage(
          name: nameController.text,
          email: emailController.text,
          subject: subjectController.text,
          message: messageController.text,
        );
  }

  void _showSuccessDialog() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "messageSent".tr(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "thanksContacting".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
            SizedBox(height: 16.h),
            AppButton(
              text: "ok".tr(),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
