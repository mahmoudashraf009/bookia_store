import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';
import '../../../generated/locale_keys.g.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> registerUser() async {

    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    print("User registered successfully");

    AppNavigator.pushReplacementNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
              LocaleKeys.helloRegister.tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 30.h),

            AppTextField(
              hintText: LocaleKeys.username.tr(),
            ),

            SizedBox(height: 15.h),

            AppTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hintText: LocaleKeys.email.tr(),
            ),

            SizedBox(height: 15.h),

            AppTextField(
              controller: passwordController,
              hintText: LocaleKeys.password.tr(),
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
              hintText: LocaleKeys.confirmPassword.tr(),
              obscureText: obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() =>
                  obscureConfirmPassword = !obscureConfirmPassword);
                },
              ),
            ),

            SizedBox(height: 25.h),

            AppButton(
              text: LocaleKeys.Register.tr(),
              onPressed: registerUser,
            ),

            SizedBox(height: 30.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.alreadyAccount.tr(),
                  style: const TextStyle(color: AppColors.darkColor),
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushNamed(Routes.login);
                  },
                  child: Text(
                    LocaleKeys.loginNow.tr(),
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