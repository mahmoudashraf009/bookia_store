import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/features/auth/cubit/auth_cubit.dart';
import 'package:bookia_store/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
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
              "welcomeBack".tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 30.h),

            AppTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: "enterEmail".tr()),

            SizedBox(height: 15.h),

            AppTextField(
              controller: passwordController,
              hintText: "enterPassword".tr(),
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
                onTap: () => AppNavigator.pushNamed(Routes.forgotPassword, arguments: ''),
                child: Text(
                  "forgotPassword".tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor),
                    ),
                  );
                } else if (state is AuthErrorState) {
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
                } else if (state is AuthSuccessState) {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
                }
              },
              child: AppButton(
                text: "login".tr(),
                onPressed: () {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("emailRequired".tr())),
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
                Expanded(child: Divider(color: theme.dividerTheme.color)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text("orText".tr(), style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider(color: theme.dividerTheme.color)),
              ],
            ),
            SizedBox(height: 20.h),
            _socialButton(
              text: "signInGoogle".tr(),
              icon: Assets.images.googleIc.image(width: 24.w),
              isDark: isDark,
            ),
            SizedBox(height: 15.h),
            _socialButton(
              text: "signInApple".tr(),
              icon: Assets.images.cibApple.image(
                width: 24.w,
                color: isDark ? Colors.white : Colors.black,
              ),
              isDark: isDark,
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "noAccount".tr(),
                  style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushNamed(Routes.register, arguments: '');
                  },
                  child: Text(
                    "registerNow".tr(),
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

  Widget _socialButton({required String text, required Widget icon, required bool isDark}) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 10.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}