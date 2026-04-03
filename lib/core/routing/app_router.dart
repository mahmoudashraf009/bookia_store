import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/ui/forgot_password_screen.dart';
import '../../features/auth/ui/otp_screen.dart';
import '../../features/auth/ui/wishlist_screen.dart';
import '../../features/home/cubit/home_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/profile/cubit/profile_cubit.dart';
import '../../features/profile/ui/profile_screen.dart';
import 'routes.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/register_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/home/ui/book_details_screen.dart';
import '../../features/home/ui/cart_screen.dart';
import '../../features/welcome/ui/welcome_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginScreen(),
          ),
        );

      case Routes.register:
        return MaterialPageRoute(
         builder: (_) => BlocProvider(
           create: (context) => AuthCubit(),
           child: const RegisterScreen(),
    ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.bookDetails:
        return MaterialPageRoute(
          builder: (_) => const BookDetailsScreen(),
          settings: settings,
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );

      case Routes.otp:
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );
      case Routes.wishlist:
        return MaterialPageRoute(
          builder: (_) => const WishlistScreen(),
        );
      case Routes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit(),
            child: const ProfileScreen(),
          ),
        );
      default:
        return null;
    }
  }
}