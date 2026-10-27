abstract class SignUpStates {}

class SignUpInitial extends SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpSuccess extends SignUpStates {}

class SignUpFailure extends SignUpStates {
  final String message;
  SignUpFailure({required this.message});
}

// **************** log in ******************* //

abstract class LogInStates {}

class LogInInitial extends LogInStates {}

class LogInLoading extends LogInStates {}

class LogInSuccess extends LogInStates {}

class LogInFailure extends LogInStates {
  final String message;
  LogInFailure({required this.message});
}

// **************** verify email ******************* //

abstract class VerifyEmailStates {}

class VerifyEmailInitial extends VerifyEmailStates {}

class VerifyEmailLoading extends VerifyEmailStates {}

class VerifyEmailSuccess extends VerifyEmailStates {}

class VerifyEmailFailure extends VerifyEmailStates {
  final String message;
  VerifyEmailFailure({required this.message});
}