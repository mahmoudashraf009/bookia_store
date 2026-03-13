import 'package:flutter/material.dart';
import '../../features/auth/ui/forgot_password_screen.dart';
import '../../features/auth/ui/otp_screen.dart';
import 'routes.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/register_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/home/ui/book_details_screen.dart';
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
          builder: (_) => const LoginScreen(),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.bookDetails:
        return MaterialPageRoute(
          builder: (_) => const BookDetailsScreen(),
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );

      case Routes.otp:
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );

      default:
        return null;
    }
  }
}