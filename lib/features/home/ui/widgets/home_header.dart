import 'package:bookia_store/core/routing/navigator.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: theme.primaryColor),
            SizedBox(width: 8.w),
            Text(
              "Bookia",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            AppNavigator.pushNamed(Routes.search);
          },
          icon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurface,
            size: 24.sp,
          ),
        ),
      ],
    );
  }
}