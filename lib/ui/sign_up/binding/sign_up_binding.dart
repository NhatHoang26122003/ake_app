import 'package:get/get.dart';
import 'package:tekup_connection_mobile/ui/sign_up/controller/sign_up_controller.dart';

import '../../../common/repository/auth_repository.dart';
import '../../../common/repository/auth_repository_impl.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(AuthRepositoryImpl());
    Get.put<SignUpController>(SignUpController());
  }
}
