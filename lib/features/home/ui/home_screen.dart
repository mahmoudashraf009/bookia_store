import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/core/widgets/app_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/home_header.dart';
import 'widgets/banner_slider.dart';
import 'widgets/best_seller_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                const HomeHeader(),
                SizedBox(height: 20.h),
                const BannerSlider(),
                SizedBox(height: 20.h),
                Text(
                  LocaleKeys.buy.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                const BestSellerSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 0),
    );
  }
}