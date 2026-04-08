import 'package:bookia_store/core/theme/app_colors.dart';
import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/core/widgets/app_text_field.dart';
import 'package:bookia_store/core/routing/navigator.dart';
import 'package:bookia_store/core/routing/routes.dart';
import 'package:bookia_store/features/order/cubit/order_cubit.dart';
import 'package:bookia_store/features/order/data/models/governorate_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  GovernorateModel? selectedGovernorate;

  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getGovernorates();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
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
        title: Text(
          "placeOrder".tr(),
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is PlaceOrderLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is PlaceOrderSuccess) {
            Navigator.pop(context);
            _showOrderSuccessDialog();
          } else if (state is PlaceOrderError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "checkoutSubtitle".tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? Colors.grey.shade400 : Colors.grey,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              AppTextField(
                controller: nameController,
                hintText: "fullName".tr(),
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: emailController,
                hintText: "email".tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: addressController,
                hintText: "address".tr(),
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: phoneController,
                hintText: "phone".tr(),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: isDark ? theme.colorScheme.surfaceVariant.withOpacity(0.1) : AppColors.grayColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: isDark ? Border.all(color: Colors.white10) : null,
                ),
                child: BlocBuilder<OrderCubit, OrderState>(
                  buildWhen: (previous, current) =>
                      current is GetGovernoratesLoading ||
                      current is GetGovernoratesSuccess ||
                      current is GetGovernoratesError,
                  builder: (context, state) {
                    final governorates = context.read<OrderCubit>().governorates;
                    if (state is GetGovernoratesLoading) {
                      return Padding(
                        padding: EdgeInsets.all(14.w),
                        child: Center(
                          child: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<GovernorateModel>(
                        isExpanded: true,
                        dropdownColor: theme.colorScheme.surface,
                        hint: Text(
                          "governorate".tr(),
                          style: TextStyle(
                            color: isDark ? Colors.grey.shade400 : AppColors.darkGrayColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        value: selectedGovernorate,
                        style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14.sp),
                        items: governorates.map((gov) {
                          return DropdownMenuItem<GovernorateModel>(
                            value: gov,
                            child: Text(gov.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGovernorate = value;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32.h),
              AppButton(
                text: "placeOrder".tr(),
                onPressed: _placeOrder,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("fillFieldsError".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedGovernorate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("selectGovernorateError".tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<OrderCubit>().placeOrder(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          governorateId: selectedGovernorate!.id,
        );
  }

  void _showOrderSuccessDialog() {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            Icon(
              Icons.check_circle,
              color: const Color(0xFF2EC4B6),
              size: 80.sp,
            ),
            SizedBox(height: 20.h),
            Text(
              "success".tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "orderSuccessSubtitle".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            AppButton(
              text: "backToHome".tr(),
              onPressed: () {
                Navigator.pop(context);
                AppNavigator.pushNamedAndRemoveUntil(Routes.home);
              },
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
