import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/features/auth/ui/login_screen.dart';
import 'package:bookia_store/gen/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
   RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
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
              LocaleKeys.helloRegister.tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.h),
            AppTextField(hintText: LocaleKeys.username.tr()),
            SizedBox(height: 15.h),
            AppTextField(hintText: LocaleKeys.email.tr()),
            SizedBox(height: 15.h),
            AppTextField(
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
              hintText: LocaleKeys.confirmPassword.tr(),
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
            AppButton(text: LocaleKeys.Register.tr()),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.alreadyAccount.tr(),
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
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