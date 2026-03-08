// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "login": "تسجيل الدخول",
  "orderNow": "احجز كتابك الان!",
  "Register": "إنشاء حساب",
  "welcomeBack": "!مرحباً بعودتك",
  "enterEmail": "أدخل بريدك الإلكتروني",
  "enterPassword": "أدخل كلمة المرور",
  "forgotPassword": "نسيت كلمة المرور؟",
  "orText": "أو",
  "signInGoogle": "تسجيل الدخول جوجل",
  "signInApple": "تسجيل الدخول آبل",
  "noAccount": "ليس لديك حساب؟",
  "registerNow": "سجل الآن",
  "helloRegister": "مرحباً! سجل للبدء",
  "username": "اسم المستخدم",
  "email": "البريد الإلكتروني",
  "password": "كلمة المرور",
  "confirmPassword": "تأكيد كلمة المرور",
  "alreadyAccount": "لديك حساب بالفعل؟",
  "loginNow": "سجل دخول الآن",
  "bestSeller": "الأكثر مبيعاً",
  "buy": "شراء",
  "addToCart": "أضف إلى السلة",
  "price": "السعر",
  "search": "بحث",
  "home": "الرئيسية",
  "bookDetails": "تفاصيل الكتاب",
  "description": "الوصف",
  "cart": "السلة"
};
static const Map<String,dynamic> _en = {
  "login": "Login",
  "orderNow": "Order Your Book Now!",
  "Register": "Register",
  "welcomeBack": "Welcome back! Glad to see you, Again!",
  "enterEmail": "Enter your email",
  "enterPassword": "Enter your password",
  "forgotPassword": "Forgot Password?",
  "orText": "Or",
  "signInGoogle": "Sign in with Google",
  "signInApple": "Sign in with Apple",
  "noAccount": "Don't have an account?",
  "registerNow": "Register Now",
  "helloRegister": "Hello! Register to get started",
  "username": "Username",
  "email": "Email",
  "password": "Password",
  "confirmPassword": "Confirm password",
  "alreadyAccount": "Already have an account?",
  "loginNow": "Login Now",
  "bestSeller": "Best Seller",
  "buy": "Buy",
  "addToCart": "Add To Cart",
  "price": "Price",
  "search": "Search"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
