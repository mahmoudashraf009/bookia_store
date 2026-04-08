import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/ui/forgot_password_screen.dart';
import '../../features/auth/ui/otp_screen.dart';
import '../../features/auth/ui/reset_password_screen.dart';
import '../../features/auth/ui/wishlist_screen.dart';
import '../../features/profile/cubit/profile_cubit.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/profile/ui/edit_profile_screen.dart';
import '../../features/profile/ui/update_password_screen.dart';
import '../../features/profile/ui/privacy_terms_screen.dart';
import '../../features/home/ui/search_screen.dart';
import '../../features/order/cubit/order_cubit.dart';
import '../../features/order/ui/checkout_screen.dart';
import '../../features/order/ui/order_history_screen.dart';
import '../../features/order/ui/order_details_screen.dart';
import '../../features/faq/cubit/faq_cubit.dart';
import '../../features/faq/ui/faq_screen.dart';
import '../../features/contact/cubit/contact_cubit.dart';
import '../../features/contact/ui/contact_screen.dart';
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
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.otp:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: OtpScreen(email: email),
          ),
        );

      case Routes.resetPassword:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: ResetPasswordScreen(
              email: args['email'],
              code: args['code'],
            ),
          ),
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

      // ===== New Routes =====

      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );

      case Routes.checkout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrderCubit(),
            child: const CheckoutScreen(),
          ),
        );

      case Routes.orderHistory:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrderCubit(),
            child: const OrderHistoryScreen(),
          ),
        );

      case Routes.orderDetails:
        final orderId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrderCubit(),
            child: OrderDetailsScreen(orderId: orderId),
          ),
        );

      case Routes.faq:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FaqCubit(),
            child: const FaqScreen(),
          ),
        );

      case Routes.contactUs:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ContactCubit(),
            child: const ContactScreen(),
          ),
        );

      case Routes.editProfile:
        final Map<String, String> args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit(),
            child: EditProfileScreen(
              name: args['name'] ?? '',
              email: args['email'] ?? '',
            ),
          ),
        );

      case Routes.updatePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit(),
            child: const UpdatePasswordScreen(),
          ),
        );

      case Routes.privacyTerms:
        return MaterialPageRoute(
          builder: (_) => const PrivacyTermsScreen(),
        );

      default:
        return null;
    }
  }
}