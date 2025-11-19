import 'package:tekup_connection_mobile/common/base/api/api_service.dart';
import 'package:tekup_connection_mobile/common/base/api/response/base_response.dart';
import 'package:tekup_connection_mobile/common/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<BaseResponse> getChatHistories() {
    return _apiService.getData(endPoint: Endpoint.getChatHistories);
  }

  @override
  Future<BaseResponse> renameChat(String chatSessionId,
      {Map<String, dynamic>? body}) {
    return _apiService.patchData(
      endPoint: Endpoint.renameChat(chatSessionId),
      data: body,
    );
  }
}

class Endpoint {
  static const getChatHistories = 'chat-sessions/get-by-user?page=1&limit=20';

  static renameChat(String chatSessionId) =>
      'chat-sessions/remane-chat-session/$chatSessionId';
}
