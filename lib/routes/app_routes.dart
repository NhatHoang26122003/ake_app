import 'package:get/get.dart';
import 'package:tekup_connection_mobile/ui/login/binding/login_binding.dart';
import 'package:tekup_connection_mobile/ui/login/screen/login_page.dart';
import 'package:tekup_connection_mobile/ui/main/binding/main_binding.dart';
import 'package:tekup_connection_mobile/ui/main/screen/main_page.dart';
import 'package:tekup_connection_mobile/ui/profile/binding/profile_binding.dart';
import 'package:tekup_connection_mobile/ui/profile/screen/profile_page.dart';
import 'package:tekup_connection_mobile/ui/sign_up/binding/sign_up_binding.dart';
import 'package:tekup_connection_mobile/ui/sign_up/screen/sign_up_page.dart';
import 'package:tekup_connection_mobile/ui/splash/binding/splash_binding.dart';

import '../ui/splash/screen/splash_page.dart';
abstract class PageName {
  static const splashPage = '/';
  static const mainPage = '/main';
  static const loginPage = '/login';
  static const signUpPage = '/signUp';
  static const profilePage = '/profile';
}

abstract class Argument {}

class AppPages {
  static final routes = [
    GetPage(
      name: PageName.splashPage,
      page: () =>  const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: PageName.mainPage,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: PageName.loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PageName.signUpPage,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: PageName.profilePage,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
