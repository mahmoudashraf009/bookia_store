import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';
import '../cubit/auth_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SendForgetPasswordLinkLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is SendForgetPasswordLinkErrorState) {
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
          } else if (state is SendForgetPasswordLinkSuccessState) {
            Navigator.pop(context);
            AppNavigator.pushNamed(
              Routes.otp,
              arguments: emailController.text,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "forgotPasswordTitle".tr(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "forgotPasswordSubtitle".tr(),
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
              SizedBox(height: 30.h),
              AppTextField(
                controller: emailController,
                hintText: "enterEmail".tr(),
              ),
              SizedBox(height: 25.h),
              AppButton(
                text: "sendCode".tr(),
                onPressed: () {
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("emailRequired".tr())),
                    );
                    return;
                  }
                  context
                      .read<AuthCubit>()
                      .sendForgetPasswordLink(email: emailController.text);
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "rememberPassword".tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () => AppNavigator.pushReplacementNamed(Routes.login),
                    child: Text(
                      "login".tr(),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}