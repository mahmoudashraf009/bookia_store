import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/features/order/cubit/order_cubit.dart';
import 'package:bookia_store/features/order/data/models/order_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().showSingleOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${"order".tr()} #${widget.orderId}",
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        buildWhen: (previous, current) =>
            current is ShowSingleOrderLoading ||
            current is ShowSingleOrderSuccess ||
            current is ShowSingleOrderError,
        builder: (context, state) {
          if (state is ShowSingleOrderLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is ShowSingleOrderError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text("failedLoadOrder".tr(),
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                ],
              ),
            );
          } else if (state is ShowSingleOrderSuccess) {
            return _buildOrderDetails(state.order);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildOrderDetails(OrderModel order) {
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

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: statusColor.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(order.status),
                  color: statusColor,
                  size: 28.sp,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "status".tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      order.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _buildSectionTitle("orderInfo".tr()),
          SizedBox(height: 12.h),
          _buildInfoRow("orderID".tr(), "#${order.id}"),
          _buildInfoRow("date".tr(), _formatDate(order.date)),
          _buildInfoRow("total".tr(), "₹${order.total}"),
          SizedBox(height: 24.h),
          _buildSectionTitle("${"items".tr()} (${order.items.length})"),
          SizedBox(height: 12.h),
          ...order.items.map((item) => _buildItemCard(item)),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.1) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "totalAmount".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  "₹${order.total}",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(OrderItemModel item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              item.image ?? '',
              width: 60.w,
              height: 80.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60.w,
                height: 80.h,
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                child: Icon(Icons.book, color: Colors.grey, size: 30.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title.isEmpty ? "Order Item" : item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "${"qty".tr()}: ${item.quantity}",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(height: 4.h),
                Text(
                  "₹${item.total}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
      case 'canceled':
        return Icons.cancel;
      case 'processing':
        return Icons.hourglass_bottom;
      case 'shipped':
        return Icons.local_shipping;
      default:
        return Icons.pending;
    }
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
