import 'package:bookia_store/core/theme/app_themes.dart';
import 'package:bookia_store/core/theme/theme_cubit.dart';
import 'package:bookia_store/features/home/ui/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helper/app_constants.dart';
import 'core/routing/app_router.dart';
import 'core/routing/navigator.dart';
import 'features/welcome/ui/welcome_screen.dart';

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
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
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeMode,
              home: startScreen(),
            );
          },
        );
      },
    );
  }

  Widget startScreen() {
    if (AppConstants.token != null) {
      return const HomeScreen();
    } else {
      return const WelcomeScreen();
    }
  }
}