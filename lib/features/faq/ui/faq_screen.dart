import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/features/faq/cubit/faq_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FaqCubit>().getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "faq".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocBuilder<FaqCubit, FaqState>(
        builder: (context, state) {
          if (state is FaqLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is FaqError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(
                    "failedLoadFaqs".tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => context.read<FaqCubit>().getFaqs(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: Text("resend".tr(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          final faqs = context.read<FaqCubit>().faqs;

          if (faqs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help_outline, size: 60.sp, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                  SizedBox(height: 12.h),
                  Text(
                    "noFaqs".tr(),
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: faqs.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black26 : Colors.grey.withAlpha(20),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Theme(
                  data: theme.copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    iconColor: AppColors.primaryColor,
                    collapsedIconColor: isDark ? Colors.grey.shade500 : Colors.grey,
                    title: Text(
                      faq.question,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    children: [
                      Divider(color: isDark ? Colors.white12 : Colors.grey.shade200),
                      SizedBox(height: 8.h),
                      Text(
                        faq.answer,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
