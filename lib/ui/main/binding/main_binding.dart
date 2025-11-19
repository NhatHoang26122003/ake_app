import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/repository/chat_repository.dart';
import 'package:tekup_connection_mobile/common/repository/chat_repository_impl.dart';
import 'package:tekup_connection_mobile/common/repository/message_repository.dart';
import 'package:tekup_connection_mobile/common/repository/message_repository_impl.dart';
import 'package:tekup_connection_mobile/ui/main/controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatRepository>(ChatRepositoryImpl());
    Get.put<MessageRepository>(MessageRepositoryImpl());
    Get.put<MainController>(MainController());
  }
}
