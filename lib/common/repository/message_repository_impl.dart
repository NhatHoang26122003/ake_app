import 'package:tekup_connection_mobile/common/base/api/api_service.dart';
import 'package:tekup_connection_mobile/common/base/api/response/base_response.dart';
import 'package:tekup_connection_mobile/common/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<BaseResponse> getMessages(String chatSessionId, int page,
      [int limit = 20]) {
    Map<String, dynamic> query = {"page": page, "limit": limit};
    return _apiService.getData(
      endPoint: Endpoint.getMessages(chatSessionId),
      query: query,
    );
  }
}

class Endpoint {
  static String getMessages(String chatSessionId) =>
      'messages/session/$chatSessionId/get-messages';
}
