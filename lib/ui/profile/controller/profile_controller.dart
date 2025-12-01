import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/controller/base_controller.dart';
import 'package:tekup_connection_mobile/common/base/controller/observer_func.dart';
import 'package:tekup_connection_mobile/common/base/storage/local_data.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository.dart';
import 'package:tekup_connection_mobile/data/model/user_model.dart';
import 'package:tekup_connection_mobile/data/response/auth_response.dart';
import 'package:tekup_connection_mobile/ui/main/controller/main_controller.dart';

class ProfileController extends BaseController {
  static ProfileController get to => Get.find<ProfileController>();

  final AuthRepository _authRepository = Get.find();
  late UserModel user;
  late TextEditingController emailController;
  late TextEditingController usernameController;


  @override
  void onInit() {
    user = LocalData.shared.user ?? UserModel(name: "U", email: "");
    emailController = TextEditingController(text:user.email);
    usernameController = TextEditingController(text: user.name);
    super.onInit();
  }


  Future<void> updateUsername(String? newUsername) async {
    if (newUsername == null) return;
    final request = {"newUsername": newUsername};
    subscribe(
      future: _authRepository.updateUsername(body: request),
      observer: ObserverFunc(
        onSubscribe: () {},
        onSuccess: (response) {
          final userResponse = AuthResponse.fromJson(response.body);
          LocalData.shared.user = userResponse.user;
          MainController.to.user.value = userResponse.user;
          showSimpleSuccessSnackBar(message: "updateUsernameSuccessful".tr);
        },
        onError: (error) {
          showSimpleErrorSnackBar(message: error.message ?? "updateUsernameFailed".tr);
        },
      ),
    );
  }
}
