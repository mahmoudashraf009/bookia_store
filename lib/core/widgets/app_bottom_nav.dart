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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(.3) : Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.colorScheme.surface,
        iconSize: 25.sp,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: isDark ? Colors.grey : Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == currentIndex) return; // Don't navigate if same tab
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
          _buildNavItem("assets/icons/Home.svg", 0),
          _buildNavItem("assets/icons/Bookmark.svg", 1),
          _buildNavItem("assets/icons/Category.svg", 2),
          _buildNavItem("assets/icons/Profile.svg", 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String assetPath, int index) {
    return BottomNavigationBarItem(
      icon: Builder(builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final isSelected = currentIndex == index;
        return SvgPicture.asset(
          assetPath,
          colorFilter: ColorFilter.mode(
            isSelected
                ? AppColors.primaryColor
                : (isDark ? Colors.grey.shade400 : Colors.black),
            BlendMode.srcIn,
          ),
        );
      }),
      label: "",
    );
  }
}