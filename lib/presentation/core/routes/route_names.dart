import 'package:flutter/material.dart';
import 'package:foodigo/presentation/screen/all_category/all_category_screen.dart';
import 'package:foodigo/presentation/screen/all_food_screen/all_food_screen.dart';
import 'package:foodigo/presentation/screen/all_restaurant_screen/all_restaurant_screen.dart';
import 'package:foodigo/presentation/screen/all_restaurant_screen/components/restaurant_profile_screen.dart';
import 'package:foodigo/presentation/screen/authentications/change_password.dart';
import 'package:foodigo/presentation/screen/authentications/forgot_password_email_phone_screen.dart';
import 'package:foodigo/presentation/screen/home/components/wishlist_screen.dart';
import 'package:foodigo/presentation/screen/my_cart/components/address_screen.dart';
import 'package:foodigo/presentation/screen/my_cart/components/edit_address_screen.dart';
import 'package:foodigo/presentation/screen/my_cart/components/order_screen.dart';
import 'package:foodigo/presentation/screen/my_cart/track_order_screen.dart';
import 'package:foodigo/presentation/screen/product_details/product_details_screen.dart';
import 'package:foodigo/presentation/screen/profile/edit_profile_screen.dart';
import 'package:foodigo/presentation/screen/profile/faq_screen.dart';
import 'package:foodigo/presentation/screen/profile/language_screen.dart';
import 'package:foodigo/presentation/screen/profile/profile_change_password_screen.dart';
import 'package:foodigo/presentation/screen/profile/settings_screen.dart';
import 'package:foodigo/presentation/screen/sms/sms_screen.dart';

import '../../screen/authentications/authentication_screen.dart';
import '../../screen/authentications/create_new_password.dart';
import '../../screen/authentications/forgot_password_screen.dart';
import '../../screen/authentications/otp_screen.dart';
import '../../screen/authentications/registration_screen.dart';
import '../../screen/main_page/main_screen.dart';
import '../../screen/my_cart/components/bank_payment_screen.dart';
import '../../screen/my_cart/payment_method_screen.dart';
import '../../screen/my_order/my_order_screen.dart';
import '../../screen/onboarding/onboarding_screen.dart';
import '../../screen/splash/splash_screen.dart';

class RouteNames {
  static const String splashScreen = '/ss';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String authenticationScreen = '/authenticationScreen';
  static const String registrationScreen = '/registrationScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String phoneVerificationScreen = '/phoneVerificationScreen';
  static const String emailVerificationScreen = '/emailVerificationScreen';
  static const String forgotPassScreen = '/forgotPassScreen';
  static const String createNewPasswordScreen = '/createNewPasswordScreen';
  static const String otpScreen = '/otpScreen';
  static const String mainScreen = '/mainScreen';
  static const String allFoodScreen = '/allFoodScreen';
  static const String allRestaurantScreen = '/allRestaurantScreen';
  static const String allCategoryScreen = '/allCategoryScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String orderScreen = '/orderScreen';
  static const String addressScreen = '/addressScreen';
  static const String editAddressScreen = '/editAddressScreen';
  static const String restaurantProfileScreen = '/restaurantProfileScreen';
  static const String wishlistScreen = '/wishlistScreen';
  static const String paymentMethodScreen = '/paymentMethodScreen';
  static const String trackOrderScreen = '/orderTrackScreen';
  static const String smsScreen = '/smsScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String settingScreen = '/settingScreen';
  static const String languageScreen = '/languageScreen';
  static const String faqScreen = '/faqScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String myOrderScreen = '/myOrderScreen';
  static const String registerOTPScreen = '/registerOTPScreen';
  static const String forgotPasswordEmailPhoneScreen =
      '/forgotPasswordEmailPhoneScreen';
  static const String profilePasswordChangeScreen =
      '/profilePasswordChangeScreen';
  static const String bankTransferPaymentScreen = '/bankTransferPaymentScreen';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnboardingScreen());

      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());

      case RouteNames.registrationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const RegistrationScreen());

      // case RouteNames.verificationScreen:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const VerificationScreen());

      case RouteNames.otpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => OtpScreen());

      case RouteNames.forgotPassScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotPasswordScreen());

      case RouteNames.createNewPasswordScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const CreateNewPasswordScreen());

      case RouteNames.mainScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainScreen());

      case RouteNames.allFoodScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllFoodScreen());

      case RouteNames.allRestaurantScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AllRestaurantScreen());

      case RouteNames.allCategoryScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllCategoryScreen());

      case RouteNames.productDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsScreen(
            id: id,
          ),
        );

      case RouteNames.orderScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const OrderScreen(),
        );

      case RouteNames.addressScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangeAddressScreen());

      case RouteNames.editAddressScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const EditAddressScreen());

      case RouteNames.restaurantProfileScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RestaurantProfileScreen(
            slug: slug,
          ),
        );

      case RouteNames.wishlistScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishlistScreen());

      case RouteNames.paymentMethodScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => PaymentMethodScreen());

      case RouteNames.trackOrderScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TrackOrderScreen());

      case RouteNames.smsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SmsScreen());
      case RouteNames.editProfileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const EditProfileScreen());
      case RouteNames.settingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingsScreen());
      case RouteNames.languageScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LanguageScreen());
      case RouteNames.faqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FaqScreen());
      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case RouteNames.myOrderScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MyOrderScreen());
      case RouteNames.forgotPasswordEmailPhoneScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ForgotPasswordEmailPhoneScreen());
      case RouteNames.profilePasswordChangeScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ProfileChangePasswordScreen());

      case RouteNames.bankTransferPaymentScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => BankPaymentScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route Found ${settings.name}'),
            ),
          ),
        );
    }
  }
}
