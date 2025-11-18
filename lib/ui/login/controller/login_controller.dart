import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:tekup_connection_mobile/common/base/controller/base_controller.dart';
import 'package:tekup_connection_mobile/common/base/controller/observer_func.dart';
import 'package:tekup_connection_mobile/common/base/storage/local_data.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository.dart';
import 'package:tekup_connection_mobile/data/request/login_request_model.dart';
import 'package:tekup_connection_mobile/data/response/auth_response.dart';
import 'package:tekup_connection_mobile/routes/app_routes.dart';

class LoginController extends BaseController {
  static LoginController get to => Get.find<LoginController>();

  final AuthRepository _authRepository = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<bool> isShowPassword = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void onNavigateSignupPage() {
    Get.toNamed(PageName.signUpPage);
  }

  void onNavigateMainPage() {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      Get.offAllNamed(PageName.mainPage);
    }
  }

  Future<void> onLogin() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      final request = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      subscribe(
        future: _authRepository.login(
          body: request.toJson(),
        ),
        observer: ObserverFunc(
          onSubscribe: () {},
          onSuccess: (response) {
            final authResponse = AuthResponse.fromJson(response.body);
            LocalData.shared.tokenData.val = authResponse.accessToken ?? "";
            LocalData.shared.user = authResponse.user;
            onNavigateMainPage();
          },
          onError: (error) {
            showSimpleErrorSnackBar(message: error.message ?? "");
          },
        ),
        isShowLoading: true,
      );
    }
  }
}
