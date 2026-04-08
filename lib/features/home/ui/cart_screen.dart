import 'package:bookia_store/core/widgets/app_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/cubit/cart_cubit.dart';
import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/core/routing/navigator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "myCart".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listenWhen: (previous, current) =>
            current is RemoveFromCartSuccess ||
            current is RemoveFromCartError ||
            current is UpdateCartSuccess ||
            current is UpdateCartError,
        listener: (context, state) {
          if (state is RemoveFromCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          } else if (state is UpdateCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is CartLoading ||
            current is CartLoaded ||
            current is CartError,
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text("somethingWentWrong".tr(),
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => context.read<CartCubit>().getCart(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: Text("resend".tr(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          } else if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80.sp,
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "emptyCart".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.cartItems.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      final book = item.book;
                      return Container(
                        padding: EdgeInsets.all(12.w),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                book.image ?? '',
                                width: 70.w,
                                height: 90.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 70.w,
                                  height: 90.h,
                                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                                  child: const Icon(Icons.book, color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          book.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .removeFromCart(item.id);
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.red.shade300,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹${item.total}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      _buildQtyButton(
                                        icon: Icons.add,
                                        onTap: () {
                                          context.read<CartCubit>().updateCart(
                                              item.id, item.quantity + 1);
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Text(
                                          "${item.quantity}".padLeft(2, '0'),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      _buildQtyButton(
                                        icon: Icons.remove,
                                        onTap: () {
                                          if (item.quantity > 1) {
                                            context
                                                .read<CartCubit>()
                                                .updateCart(
                                                    item.id,
                                                    item.quantity - 1);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black45 : Colors.black.withAlpha(12),
                        offset: const Offset(0, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${"total".tr()}:",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "₹ ${state.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      AppButton(
                        text: "checkout".tr(),
                        onPressed: () {
                          AppNavigator.pushNamed(Routes.checkout);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildQtyButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          border: Border.all(color: isDark ? Colors.white24 : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Icon(icon, size: 16.sp, color: theme.colorScheme.onSurface),
      ),
    );
  }
}
