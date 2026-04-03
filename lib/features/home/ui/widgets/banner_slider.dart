import 'package:bookia_store/features/home/cubit/home_cubit.dart';
import 'package:bookia_store/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<String> sliders = [];
        if (state is HomeSuccess && state.sliders.isNotEmpty) {
          sliders = state.sliders;
        }

        if (sliders.isEmpty) {
          return Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: Color(0xffC49A3A).withAlpha(30),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(
                Icons.menu_book,
                size: 50.sp,
                color: Color(0xffC49A3A),
              ),
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 150.h,
              child: PageView.builder(
                itemCount: sliders.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        sliders[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xffC49A3A).withAlpha(30),
                            child: Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                sliders.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: currentIndex == index ? 36.w : 7.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Color(0xffC49A3A)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}