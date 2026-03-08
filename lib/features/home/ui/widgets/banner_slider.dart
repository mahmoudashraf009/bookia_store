import 'package:bookia_store/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}
class _BannerSliderState extends State<BannerSlider> {
  int currentIndex = 0;
  final List banners = [
    Assets.images.splash.provider(),
    Assets.images.splashAndroid12.provider(),
    Assets.images.googleIc.provider(),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: 150.h,
          child: PageView.builder(
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  image: DecorationImage(
                    image: banners[index],
                    fit: BoxFit.fill,
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
            banners.length,
                (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: currentIndex == index ? 36.w: 7.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: currentIndex == index?
                Color(0xffC49A3A)
                : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        )
      ],
    );
  }
}