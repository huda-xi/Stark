import 'package:dartz/dartz.dart';
import 'package:stark/core/failure.dart';
import 'package:stark/features/auth/signup/data/models/sign_up_model.dart';

abstract class SignupRepo {

  Future<Either<ApiError,SignUpModel>> signUpUser({required SignUpModel signUpModel});
}