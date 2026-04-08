import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/features/auth/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
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
            AppNavigator.pushReplacementNamed(Routes.home);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "helloRegister".tr(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 30.h),
              AppTextField(
                controller: nameController,
                hintText: "username".tr(),
              ),
              SizedBox(height: 15.h),
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: "email".tr(),
              ),
              SizedBox(height: 15.h),
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
                text: "Register".tr(),
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("somethingWentWrong".tr())),
                    );
                    return;
                  }
                  context.read<AuthCubit>().register(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        passwordConfirmation: confirmPasswordController.text,
                      );
                },
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "alreadyAccount".tr(),
                    style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.pushNamed(Routes.login, arguments: '');
                    },
                    child: Text(
                      "loginNow".tr(),
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
      ),
    );
  }
}