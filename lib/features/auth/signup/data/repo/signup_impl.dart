import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stark/core/Api_Service.dart';
import 'package:stark/core/failure.dart';
import 'package:stark/features/auth/signup/data/models/sign_up_model.dart';
import 'package:stark/features/auth/signup/data/repo/signup_repo.dart';

class SignupImpl implements SignupRepo {
  final ApiService apiService;

  SignupImpl({required this.apiService});
  @override
  Future<Either<ApiError, SignUpModel>> signUpUser({
    required SignUpModel signUpModel,
  }) async {
    try {
      var data = await apiService.post(
        endpoint: 'api/auth/register',
        data: {
          'email': signUpModel.email,
          'password': signUpModel.pass,
          'firstName': signUpModel.fname,
          'lastName': signUpModel.lname,
        },
      );
      return right(SignUpModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ApiError.fromDioException(e));
      }
      return left(ApiError(message: e.toString()));
    }
  }
}
