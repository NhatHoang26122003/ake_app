import 'package:tekup_connection_mobile/common/base/api/api_service.dart';
import 'package:tekup_connection_mobile/common/base/api/response/base_response.dart';
import 'package:tekup_connection_mobile/common/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<BaseResponse> login({Map<String, dynamic>? body}) {
    return _apiService.postData(endPoint: Endpoint.login, data: body);
  }

  @override
  Future<BaseResponse> signUp({Map<String, dynamic>? body}) {
    return _apiService.postData(endPoint: Endpoint.signUp, data: body);
  }

  @override
  Future<BaseResponse> updateUsername({Map<String, dynamic>? body}) {
    return _apiService.patchData(endPoint: Endpoint.updateUsername, data: body);
  }

  @override
  Future<BaseResponse> changePassword({Map<String, dynamic>? body}) {
    return _apiService.patchData(endPoint: Endpoint.changePassword, data: body);
  }
}

class Endpoint {
  static const login = 'users/login';
  static const signUp = 'users/sign-up';
  static const updateUsername = 'users/username';
  static const changePassword = 'users/password';
}
