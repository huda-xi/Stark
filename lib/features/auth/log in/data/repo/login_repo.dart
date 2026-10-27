import 'package:dartz/dartz.dart';
import 'package:stark/core/failure.dart';
import 'package:stark/features/auth/log%20in/data/models/login_model.dart';

abstract class LoginRepo {

  Future <Either<ApiError,LogInModel>> LoginUser({required email, required password});

}