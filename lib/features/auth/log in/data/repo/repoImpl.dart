import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stark/core/Api_Service.dart';
import 'package:stark/core/failure.dart';
import 'package:stark/core/token_manager.dart';
import 'package:stark/features/auth/log%20in/data/models/login_model.dart';
import 'package:stark/features/auth/log%20in/data/repo/login_repo.dart';

class RepoImpl implements LoginRepo {
  final ApiService apiService;

  RepoImpl({required this.apiService});
  @override
  Future<Either<ApiError, LogInModel>> LoginUser({
    required email,
    required password,
  }) async {
    try {
      var data = await apiService.post(
        endpoint: 'api/auth/login',
        data: {'email': email, "password": password},
      );
        final loginModel = LogInModel.fromJson(
      Map<String, dynamic>.from(data),
    );

    final token = loginModel.accessToken;

    if (token != null && token.isNotEmpty) {
      await TokenManager.saveToken(token);
    } else {
      throw Exception('Access token not found in login response');
    }

    return right(loginModel);
  } catch (e) {
    if (e is DioException) {
      return left(ApiError.fromDioException(e));
    }

    return left(ApiError(message: e.toString()));
  }
}
}