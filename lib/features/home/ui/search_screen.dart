import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/routing/navigator.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/features/home/cubit/home_cubit.dart';
import 'package:bookia_store/features/home/cubit/home_state.dart';
import 'package:bookia_store/features/home/data/models/book_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
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
        title: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.2) : const Color(0xFFF7F8F9),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: TextField(
            controller: searchController,
            focusNode: _focusNode,
            style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14.sp),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: "searchPlaceholder".tr(),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.grey.shade500 : Colors.grey,
              ),
              prefixIcon: Icon(Icons.search, color: isDark ? Colors.grey.shade400 : Colors.grey, size: 20.sp),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<HomeCubit>().searchProducts(value);
              }
            },
            onChanged: (value) {
              if (value.isEmpty) {
                context.read<HomeCubit>().clearSearch();
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (searchController.text.isNotEmpty) {
                context.read<HomeCubit>().searchProducts(searchController.text);
              }
            },
            child: Text(
              "search".tr(),
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is SearchLoading ||
            current is SearchSuccess ||
            current is SearchError ||
            current is SearchCleared,
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is SearchError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 60.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(
                    "somethingWentWrong".tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else if (state is SearchSuccess) {
            final results = context.read<HomeCubit>().searchResults;
            if (results.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 60.sp, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                    SizedBox(height: 12.h),
                    Text(
                      "noBooksFound".tr(),
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "tryDifferentSearch".tr(),
                      style: TextStyle(fontSize: 13.sp, color: isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                    ),
                  ],
                ),
              );
            }
            return _buildSearchResults(results);
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 60.sp, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                SizedBox(height: 12.h),
                Text(
                  "searchPrompt".tr(),
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(List<BookModel> results) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.65,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final book = results[index];
        return GestureDetector(
          onTap: () {
            AppNavigator.pushNamed(Routes.bookDetails, arguments: book);
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
                      errorBuilder: (_, __, ___) => Container(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        child: Center(
                          child: Icon(Icons.book, color: Colors.grey, size: 40.sp),
                        ),
                      ),
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
                      Text(
                        "${book.price} ${"price".tr().split(' ').last}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
