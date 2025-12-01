import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository_impl.dart';
import 'package:tekup_connection_mobile/ui/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(AuthRepositoryImpl());
    Get.put<ProfileController>(ProfileController());
  }
}
