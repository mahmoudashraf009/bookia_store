import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)?.settings.arguments as BookModel?;

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Book Details")),
        body: Center(child: Text("No book data")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.h,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'book_${book.id}',
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(Icons.book, color: Colors.grey, size: 80.sp),
                      ),
                    );
                  },
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
                  // Title
                  Text(
                    book.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Category
                  if (book.category.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        book.category,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  SizedBox(height: 16.h),

                  // Price
                  Row(
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "₹${book.price}",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Wishlist status
                  Row(
                    children: [
                      Icon(
                        book.inWishlist ? Icons.bookmark : Icons.bookmark_border,
                        color: book.inWishlist ? AppColors.primaryColor : Colors.grey,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        book.inWishlist ? "In Wishlist" : "Add to Wishlist",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: book.inWishlist ? AppColors.primaryColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Description
                  if (book.description.isNotEmpty) ...[
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      book.description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ],
                  SizedBox(height: 30.h),

                  // Buy Button
                  AppButton(
                    text: "Buy Now - ₹${book.price}",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added to cart!"),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
