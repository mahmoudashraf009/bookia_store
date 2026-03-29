import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/features/auth/cubit/auth_cubit.dart';
import 'package:bookia_store/features/auth/ui/register_screen.dart';
import 'package:bookia_store/gen/assets.gen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';
import '../../../generated/locale_keys.g.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.welcomeBack.tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.boldColor,
              ),
            ),
            SizedBox(height: 30.h),

            AppTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: LocaleKeys.enterEmail.tr()),

            SizedBox(height: 15.h),

            AppTextField(
              controller: passwordController,
              hintText: LocaleKeys.enterPassword.tr(),
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
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => AppNavigator.pushNamed(Routes.forgotPassword),
                child: Text(
                  LocaleKeys.forgotPassword.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.boldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  showDialog(context: context, builder: (context) =>
                      Center(child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )));
                } else if (state is AuthErrorState) {
                  Navigator.pop(context);
                  showDialog(context: context, builder: (context) =>
                      AlertDialog(
                        title: Text("Error"),
                        content: Text("Something wrong please try again"),
                      ));
                } else if (state is AuthSuccessState) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.home, (route) => false);
                }
              },
              child: AppButton(text: LocaleKeys.login.tr(),
                onPressed: () {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter email and password")),
                    );
                    return;
                  }
                  context.read<AuthCubit>().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(LocaleKeys.orText.tr(),
                      style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.googleIc.image(width: 24.w),
                  SizedBox(width: 10.w),
                  Text(LocaleKeys.signInGoogle.tr()),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.cibApple.image(width: 24.w),
                  SizedBox(width: 10.w),
                  Text(LocaleKeys.signInApple.tr()),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.noAccount.tr(),
                  style: TextStyle(color: AppColors.darkColor),
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushNamed(Routes.register);
                  },
                  child: Text(
                    LocaleKeys.registerNow.tr(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}