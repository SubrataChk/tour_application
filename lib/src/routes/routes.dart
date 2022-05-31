import 'package:get/get.dart';
import 'package:tour_application/src/view/auth/log_in.dart';
import 'package:tour_application/src/view/auth/sign_up.dart';
import 'package:tour_application/src/view/auth/user_form.dart';
import 'package:tour_application/src/view/bottom/bottom_nav.dart';
import 'package:tour_application/src/view/onbording.dart';
import 'package:tour_application/src/view/privacy/privacy_policy.dart';
import 'package:tour_application/src/view/splash.dart';

const String splash = "/splash-screen";
const String onBording = "/onBoard-screen";
const String signupScreen = "/signUp-screen";
const String logInScreen = "/login-screen";
const String userFormScreen = "/userFormScreen-screen";
const String privacyPolicy = "/privacyPolicy-screen";
const String bottomNavController = "/bottomNavController-screen";

List<GetPage> getPages = [
  GetPage(name: splash, page: () => const SplashScreen()),
  GetPage(name: onBording, page: () => OnBoardingPage()),
  GetPage(name: signupScreen, page: () => SignUpPage()),
  GetPage(name: logInScreen, page: () => LogInPage()),
  GetPage(name: userFormScreen, page: () => UserFormSection()),
  GetPage(name: privacyPolicy, page: () => PrivacyPolicy()),
  GetPage(name: bottomNavController, page: () => BottomNavController())
];
