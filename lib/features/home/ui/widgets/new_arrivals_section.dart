import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/features/home/cubit/home_cubit.dart';
import 'package:bookia_store/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/book_model.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetNewArrivalsSuccess ||
          current is GetNewArrivalsLoading ||
          current is GetNewArrivalsError,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        if (state is GetNewArrivalsLoading && cubit.newArrivalBooks.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is GetNewArrivalsError &&
            cubit.newArrivalBooks.isEmpty) {
          return Center(
            child: Text(
              "Failed to load new arrivals",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          );
        } else if (cubit.newArrivalBooks.isNotEmpty) {
          return SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.newArrivalBooks.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                return _buildNewArrivalItem(
                    context, cubit.newArrivalBooks[index]);
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildNewArrivalItem(BuildContext context, BookModel book) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/bookDetails',
          arguments: book,
        );
      },
      child: Container(
        width: 140.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(25),
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
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(12.r)),
                child: Image.network(
                  book.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child:
                            Icon(Icons.book, color: Colors.grey, size: 40.sp),
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
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${book.price}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "Buy",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
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
