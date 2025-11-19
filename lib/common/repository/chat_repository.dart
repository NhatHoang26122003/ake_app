import 'package:tekup_connection_mobile/common/base/api/response/base_response.dart';

abstract class ChatRepository{

  Future<BaseResponse> getChatHistories();
}