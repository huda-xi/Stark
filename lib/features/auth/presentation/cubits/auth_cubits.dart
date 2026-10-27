
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stark/core/Api_Service.dart';
import 'package:stark/core/controllers.dart';
import 'package:stark/features/auth/log%20in/data/repo/login_repo.dart';
import 'package:stark/features/auth/presentation/cubits/cubit_states.dart';
import 'package:stark/features/auth/signup/data/models/sign_up_model.dart';
import 'package:stark/features/auth/signup/data/repo/signup_repo.dart';



class LogInCubit extends Cubit<LogInStates> {
  bool isLoading = false;
  LogInCubit({required this.loginRepo}) : super(LogInInitial());

  LoginRepo loginRepo;

  Future<void> postLogIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;
    emit(LogInLoading());
    final result = await loginRepo.LoginUser(
      email: logemailctrl.text.trim(),
      password: logpassctrl.text,
    );
    result.fold(
      (ApiError) {
        isLoading = false;
        emit(LogInFailure(message: ApiError.message));
      },
      (token) {
        isLoading = false;
        pref.setString('token', token.accessToken.toString());
        emit(LogInSuccess());
      },
    );
  }
}

// *************************** sign up ************************//

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit({required this.signupRepo}) : super(SignUpInitial());

  SignupRepo signupRepo;

  Future<void> postSignUp() async {
    emit(SignUpLoading());

    final result = await signupRepo.signUpUser(
      signUpModel: SignUpModel(
        email: emailctrl.text.trim(),
        pass: passctrl.text,
        fname: fnamectrl.text.trim(),
        lname: lnamectrl.text.trim(),
      ),
    );

    result.fold(
      (failure) {
        emit(SignUpFailure(message: failure.message));
      },
      (user) {
        emit(SignUpSuccess());
      },
    );
  }
}

// ******************************** verify email *******************************//

class VerifyEmailCubit extends Cubit<VerifyEmailStates>{
  VerifyEmailCubit({required this.apiService}):super(VerifyEmailInitial());

  final ApiService apiService;

  Future<void> verifyEmail({
    required String email,
    required String otp
  }) async{
    emit(VerifyEmailLoading());
    try {
      await apiService.verifyEmail(email: email, otp: otp);
      emit(VerifyEmailSuccess());
    } catch (e) {
      emit(VerifyEmailFailure(message: 'verify failed'));
      
    }
  }
}
