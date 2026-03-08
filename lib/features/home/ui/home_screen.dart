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
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            iconSize: 25.sp,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items:[

              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: "",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "",
              ),
            ],
          ),
        )
    );
  }
}