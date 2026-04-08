import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/features/profile/cubit/profile_cubit.dart';
import 'package:bookia_store/features/profile/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
          "resetPassword".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdatePasswordLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is UpdatePasswordSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("updateSuccess".tr()),
                backgroundColor: AppColors.primaryColor,
              ),
            );
            Navigator.pop(context);
          } else if (state is UpdatePasswordError) {
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "currentPassword".tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: currentPasswordController,
                hintText: "currentPassword".tr(),
                obscureText: obscureCurrent,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureCurrent ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => obscureCurrent = !obscureCurrent),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "newPassword".tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: newPasswordController,
                hintText: "newPassword".tr(),
                obscureText: obscureNew,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureNew ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => obscureNew = !obscureNew),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "confirmPassword".tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: confirmPasswordController,
                hintText: "confirmPassword".tr(),
                obscureText: obscureConfirm,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
                ),
              ),
              SizedBox(height: 40.h),
              AppButton(
                text: "updatePassword".tr(),
                onPressed: _updatePassword,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePassword() {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("fillFieldsError".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("passwordsNotMatch".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    context.read<ProfileCubit>().updatePassword(
          currentPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }
}
