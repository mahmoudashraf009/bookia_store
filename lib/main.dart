import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'book_store_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale:  Locale('en'),
      child:  BookStoreApp(),
    ),
  );
}







//flutter pub run easy_localization:generate -S assets/translations -O lib/gen/translations -o locale_keys.g.dart -f keys