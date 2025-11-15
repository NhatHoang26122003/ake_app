import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/controller/base_controller.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository.dart';
import 'package:tekup_connection_mobile/routes/app_routes.dart';

class SignUpController extends BaseController {
  static SignUpController get to => Get.find<SignUpController>();

  AuthRepository repository = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<bool> isShowPassword = false.obs;
  Rx<bool> isShowConfirmPassword = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void toggleShowPassword (){
    isShowPassword.value = !isShowPassword.value;
  }

  void toggleShowConfirmPassword (){
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }


  void onSignUp(){
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      Get.offAllNamed(PageName.loginPage);
    }
  }

  void onNavigateLoginPage(){
    Get.toNamed(PageName.loginPage);
  }
}
