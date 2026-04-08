import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/features/home/cubit/home_cubit.dart';
import 'package:bookia_store/features/home/cubit/home_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/book_model.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetBestSellerSuccess ||
          current is GetBestSellerLoading ||
          current is GetBestSellerError,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        if (state is GetBestSellerLoading && cubit.bestSellerBooks.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is GetBestSellerError && cubit.bestSellerBooks.isEmpty) {
          return Center(
            child: Column(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40.sp),
                SizedBox(height: 8.h),
                Text(
                  "somethingWentWrong".tr(),
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeCubit>().getBestSeller();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text("resend".tr(), style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else if (cubit.bestSellerBooks.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.65,
            ),
            itemCount: cubit.bestSellerBooks.length,
            itemBuilder: (context, index) {
              return _buildBookItem(context, cubit.bestSellerBooks[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildBookItem(BuildContext context, BookModel book) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/bookDetails',
          arguments: book,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.grey.withAlpha(25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: Image.network(
                  book.image ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                      child: Center(
                        child: Icon(Icons.book, color: Colors.grey, size: 40.sp),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${book.price} ${"price".tr().split(' ').last}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? theme.primaryColor.withOpacity(0.2) : Colors.black,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "buy".tr(),
                          style: TextStyle(
                            color: isDark ? theme.primaryColor : Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}