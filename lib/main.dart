import 'package:bookia_store/core/helper/app_constants.dart';
import 'package:bookia_store/features/home/ui/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'book_store_app.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/home/data/repo/home_repo.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/cart/data/repo/cart_repo.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  AppConstants.token=prefs.getString("token");
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit(HomeRepo(Dio()))),
          BlocProvider(create: (context) => CartCubit(CartRepo(Dio()))),
          BlocProvider(create: (context) => WishlistCubit()),
        ],
        child: BookStoreApp(),
      ),
    ),
  );
}







//flutter pub run easy_localization:generate -S assets/translations -O lib/gen/translations -o locale_keys.g.dart -f keys
// flutter pub run easy_localization:generate -S assets/translations -O lib/gen/translations -o locale_keys.g.dart -f keys
// dart run build_runner build --delete-conflicting-outputs