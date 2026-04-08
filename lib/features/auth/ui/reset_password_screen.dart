import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';
import '../cubit/auth_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(
                  child: CircularProgressIndicator(color: AppColors.primaryColor),
                ),
              );
            } else if (state is ResetPasswordErrorState) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("error".tr()),
                  content: Text("somethingWentWrong".tr()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("done".tr()),
                    )
                  ],
                ),
              );
            } else if (state is ResetPasswordSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("updateSuccess".tr())),
              );
              AppNavigator.pushNamedAndRemoveUntil(Routes.login);
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "resetPasswordTitle".tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "resetPasswordSubtitle".tr(),
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(height: 30.h),
                AppTextField(
                  controller: passwordController,
                  hintText: "password".tr(),
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => obscurePassword = !obscurePassword);
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                AppTextField(
                  controller: confirmPasswordController,
                  hintText: "confirmPassword".tr(),
                  obscureText: obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => obscureConfirmPassword = !obscureConfirmPassword);
                    },
                  ),
                ),
                SizedBox(height: 25.h),
                AppButton(
                  text: "resetPassword".tr(),
                  onPressed: () {
                    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("passwordRequired".tr())),
                      );
                      return;
                    }
                    if (passwordController.text != confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("passwordsNotMatch".tr())),
                      );
                      return;
                    }
                    context.read<AuthCubit>().resetPassword(
                          email: widget.email,
                          code: widget.code,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text,
                        );
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
