import 'package:tekup_connection_mobile/common/base/api/response/base_response.dart';

abstract class MessageRepository{

  Future<BaseResponse> getMessages(String chatSessionId, int page, [int limit = 10]);
}