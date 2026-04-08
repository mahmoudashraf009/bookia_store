import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/routing/navigator.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/features/order/cubit/order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/models/order_model.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getOrderHistory();
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
          "myOrders".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        buildWhen: (previous, current) =>
            current is OrderHistoryLoading ||
            current is OrderHistorySuccess ||
            current is OrderHistoryError,
        builder: (context, state) {
          if (state is OrderHistoryLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is OrderHistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(
                    "failedLoadOrders".tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<OrderCubit>().getOrderHistory(),
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

          final orders = context.read<OrderCubit>().orders;

          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 80.sp,
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "noOrders".tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "startShoppingSubtitle".tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: orders.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return _buildOrderCard(orders[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color statusColor;
    switch (order.status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'cancelled':
      case 'canceled':
        statusColor = Colors.red;
        break;
      case 'processing':
      case 'shipped':
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.orange;
    }

    return GestureDetector(
      onTap: () {
        AppNavigator.pushNamed(Routes.orderDetails, arguments: order.id);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.grey.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"order".tr()} #${order.id}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: statusColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14.sp, color: Colors.grey),
                    SizedBox(width: 6.w),
                    Text(
                      _formatDate(order.date),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  "₹${order.total}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.shopping_bag_outlined,
                    size: 14.sp, color: Colors.grey),
                SizedBox(width: 6.w),
                Text(
                  "${order.items.length} ${"itemCount".tr()}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios,
                    size: 14.sp, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return "N/A";
    try {
      final parsed = DateTime.parse(date);
      return "${parsed.day}/${parsed.month}/${parsed.year}";
    } catch (_) {
      return date;
    }
  }
}
