import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';
import '../../../gen/assets.gen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.welcomeBackground.image().image,
            fit: BoxFit.cover,
            colorFilter: isDark 
                ? ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken)
                : null,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    if (context.locale.languageCode == "ar") {
                      context.setLocale(const Locale("en"));
                    } else {
                      context.setLocale(const Locale("ar"));
                    }
                  },
                  icon: Icon(
                    Icons.language,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.h),
            Assets.images.splash.image(width: 200.w),
            SizedBox(height: 28.h),
            Expanded(
              child: Text(
                "orderNow".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : const Color(0xff2F2F2F),
                ),
              ),
            ),
            AppButton(
              text: "login".tr(),
              onPressed: () {
                AppNavigator.pushNamed(Routes.login, arguments: '');
              },
            ),
            SizedBox(height: 15.h),
            AppButton(
              text: "Register".tr(),
              onPressed: () {
                AppNavigator.pushNamed(Routes.register, arguments: '');
              },
              backgroundColor: isDark ? Colors.transparent : Colors.white,
            ),
            SizedBox(height: 80.h)
          ],
        ),
      ),
    );
  }
}
