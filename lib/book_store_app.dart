import 'package:bookia_store/features/auth/ui/forgot_password_screen.dart';
import 'package:bookia_store/features/auth/ui/otp_screen.dart';
import 'package:bookia_store/features/home/ui/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/app_router.dart';
import 'core/routing/navigator.dart';
import 'features/welcome/ui/welcome_screen.dart';

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          onGenerateRoute: AppRouter().onGenerateRoute,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            fontFamily: "DM",
          ),
          home:  OtpScreen(),
        );
      },
    );
  }
}