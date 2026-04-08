import 'package:bookia_store/core/routing/navigator.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/core/widgets/app_bottom_nav.dart';
import 'package:bookia_store/core/theme/theme_cubit.dart';
import 'package:bookia_store/features/profile/cubit/profile_cubit.dart';
import 'package:bookia_store/features/profile/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _currentName = "User";
  String _currentEmail = "email@example.com";

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: Icon(
              Icons.logout,
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.welcome,
              (route) => false,
            );
          } else if (state is LogoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileLoaded) {
            _currentName = state.profile.name;
            _currentEmail = state.profile.email;
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.primaryColor,
                ),
              );
            }
            return _buildProfileContent(_currentName, _currentEmail);
          },
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  Widget _buildProfileContent(String name, String email) {
    final theme = Theme.of(context);
    final isDark = context.watch<ThemeCubit>().isDarkMode;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          CircleAvatar(
            radius: 40.r,
            backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            child: Icon(
              Icons.person,
              size: 45.sp,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            email,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30.h),

          // Appearance Section
          _buildSectionHeader("appearance".tr()),
          _buildToggleItem(
            icon: Icons.dark_mode_outlined,
            title: "darkMode".tr(),
            value: isDark,
            onChanged: (val) {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          _buildMenuItem(
            icon: Icons.language_outlined,
            title: "language".tr(),
            trailing: Text(
              context.locale.languageCode == 'ar' ? "arabic".tr() : "english".tr(),
              style: TextStyle(fontSize: 13.sp, color: theme.primaryColor),
            ),
            onTap: _showLanguageDialog,
          ),

          SizedBox(height: 20.h),
          _buildSectionHeader("profile".tr()),
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: "myOrders".tr(),
            onTap: () => AppNavigator.pushNamed(Routes.orderHistory),
          ),
          _buildMenuItem(
            icon: Icons.edit_outlined,
            title: "editProfile".tr(),
            onTap: () => AppNavigator.pushNamed(
              Routes.editProfile,
              arguments: {'name': name, 'email': email},
            ),
          ),
          _buildMenuItem(
            icon: Icons.lock_outline,
            title: "resetPassword".tr(),
            onTap: () => AppNavigator.pushNamed(Routes.updatePassword),
          ),
          
          SizedBox(height: 20.h),
          _buildSectionHeader("faq".tr()),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: "faq".tr(),
            onTap: () => AppNavigator.pushNamed(Routes.faq),
          ),
          _buildMenuItem(
            icon: Icons.headset_mic_outlined,
            title: "contactUs".tr(),
            onTap: () => AppNavigator.pushNamed(Routes.contactUs),
          ),
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: "privacyTerms".tr(),
            onTap: () => AppNavigator.pushNamed(Routes.privacyTerms),
            showDivider: false,
          ),

          SizedBox(height: 30.h),
          _logoutButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    bool showDivider = true,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: [
                Icon(icon, size: 22.sp, color: theme.colorScheme.onSurface.withOpacity(0.8)),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                trailing ?? Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: theme.dividerTheme.color),
      ],
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            children: [
              Icon(icon, size: 22.sp, color: theme.colorScheme.onSurface.withOpacity(0.8)),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: theme.primaryColor,
              ),
            ],
          ),
        ),
        Divider(height: 1, color: theme.dividerTheme.color),
      ],
    );
  }

  Widget _logoutButton() {
    return GestureDetector(
      onTap: () => _showLogoutDialog(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.red, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              "logout".tr(),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("language".tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("english".tr()),
              onTap: () {
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("arabic".tr()),
              onTap: () {
                context.setLocale(const Locale('ar'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text("logout".tr()),
        content: Text("logoutConfirm".tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("cancel".tr(), style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileCubit>().logout();
            },
            child: Text("logout".tr(), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
