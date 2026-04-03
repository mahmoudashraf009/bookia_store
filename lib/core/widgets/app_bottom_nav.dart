import 'package:bookia_store/core/routing/navigator.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 25.sp,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == 0) {
            AppNavigator.pushReplacementNamed(Routes.home);
          } else if (index == 1) {
            AppNavigator.pushReplacementNamed(Routes.wishlist);
          } else if (index == 2) {
            AppNavigator.pushReplacementNamed(Routes.cart);
          } else if (index == 3) {
            AppNavigator.pushReplacementNamed(Routes.profile);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Home.svg",
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
          "assets/icons/Bookmark.svg"
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/Category.svg"
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/icons/Profile.svg"
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}