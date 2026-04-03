import 'package:bookia_store/core/widgets/app_button.dart';
import 'package:bookia_store/features/auth/ui/register_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routing/navigator.dart';
import '../../../core/routing/routes.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../auth/ui/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:Assets.images.welcomeBackground.image().image,
            fit: BoxFit.cover
          ),
          ),
        child: Column(
          children: [
            SizedBox(height: 30.h,),
            Row(
              children: [
                IconButton(onPressed: (){
                  if(context.locale.languageCode=="ar"){
                    context.setLocale(Locale("en"));
                  }else{
                    context.setLocale(Locale("ar"));
                  }
                }, icon: Icon(Icons.language)),
              ],
            ),
            SizedBox(height: 90.h),
         Assets.images.splash.image(),
            SizedBox(height: 28.h,),
            Expanded(
              child: Text(LocaleKeys.orderNow.tr(),
                style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff2F2F2F)
              ),),
            ),
            AppButton(
              text: LocaleKeys.login.tr(),
              onPressed: () {
                AppNavigator.pushNamed(Routes.login, arguments: '');
              },
            ),
            SizedBox(height: 15.h),
            AppButton(
              text:LocaleKeys.Register.tr(),
              onPressed: () {
                AppNavigator.pushNamed(Routes.register, arguments: '');
              },
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 94.h)
          ]
        ),
        ),
      );
  }
}
