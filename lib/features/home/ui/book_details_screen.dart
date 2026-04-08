import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../wishlist/cubit/wishlist_cubit.dart';
import '../data/models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)?.settings.arguments as BookModel?;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: Text("bookDetails".tr())),
        body: Center(child: Text("noBookData".tr())),
      );
    }

    return Scaffold(
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCartLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is AddToCartSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("addedToCart".tr()),
                backgroundColor: AppColors.primaryColor,
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (state is AddToCartError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.h,
              pinned: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: isDark ? theme.colorScheme.surface : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black45 : Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: theme.colorScheme.onSurface),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    final isWishlisted = context.read<WishlistCubit>().isInWishlist(book.id);
                    return IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: isDark ? theme.colorScheme.surface : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black45 : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          isWishlisted ? Icons.bookmark : Icons.bookmark_border,
                          size: 20.sp,
                          color: isWishlisted ? AppColors.primaryColor : theme.colorScheme.onSurface,
                        ),
                      ),
                      onPressed: () {
                        context.read<WishlistCubit>().toggleWishlist(book);
                        final isNowWishlisted = context.read<WishlistCubit>().isInWishlist(book.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isNowWishlisted ? "addedToWishlist".tr() : "removedFromWishlist".tr()),
                            backgroundColor: AppColors.primaryColor,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 10.w),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'book_${book.id}',
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          book.image ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                            child: Center(child: Icon(Icons.book, color: Colors.grey, size: 80.sp)),
                          ),
                        ),
                      ),
                      if (isDark)
                        Positioned.fill(
                          child: Container(color: Colors.black.withOpacity(0.2)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title ?? '',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (book.category?.isNotEmpty == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          book.category ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Text(
                          "price".tr().split(' ').first, // Taking "Price" word
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "₹${book.price}",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    if (book.description?.isNotEmpty == true) ...[
                      Text(
                        "description".tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        book.description ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                          height: 1.6,
                        ),
                      ),
                    ],
                    SizedBox(height: 30.h),
                    AppButton(
                      text: "${"buyNow".tr()} - ₹${book.price}",
                      onPressed: () {
                        context.read<CartCubit>().addToCart(book.id);
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
