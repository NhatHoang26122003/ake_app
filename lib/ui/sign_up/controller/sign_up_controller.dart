import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/controller/base_controller.dart';
import 'package:tekup_connection_mobile/common/base/controller/observer_func.dart';
import 'package:tekup_connection_mobile/common/base/storage/local_data.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository.dart';
import 'package:tekup_connection_mobile/data/request/sign_up_request_model.dart';
import 'package:tekup_connection_mobile/data/response/auth_response.dart';
import 'package:tekup_connection_mobile/routes/app_routes.dart';

class SignUpController extends BaseController {
  static SignUpController get to => Get.find<SignUpController>();

  final AuthRepository _authRepository = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<bool> isShowPassword = false.obs;
  Rx<bool> isShowConfirmPassword = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
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
      final request = SignUpRequestModel(
        username: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      subscribe(
        future: _authRepository.signUp(
          body: request.toJson(),
        ),
        observer: ObserverFunc(
            onSubscribe: () {},
            onSuccess: (response) {
              final authResponse = AuthResponse.fromJson(response.body);
              LocalData.shared.tokenData.val = authResponse.accessToken??"";
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

  void onNavigateLoginPage(){
    Get.toNamed(PageName.loginPage);
  }

  void onNavigateMainPage(){
    Get.toNamed(PageName.mainPage);
  }
}
