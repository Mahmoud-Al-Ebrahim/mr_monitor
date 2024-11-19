part of 'auth_bloc.dart';
@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class GetProfileLoadingState extends AuthState{}
class UpdateProfileLoadingState extends AuthState{}
class LoginLoadingState extends AuthState{}
class RegisterLoadingState extends AuthState{}
class LogoutLoadingState extends AuthState{}
class SendOtpLoadingState extends AuthState{}
class VerifyOtpLoadingState extends AuthState{}
class ResetPasswordLoadingState extends AuthState{}

class LoginFailureState extends AuthState{
  String message;
  LoginFailureState(this.message);
}

class GetProfileFailureState extends AuthState{
  String message;
  GetProfileFailureState(this.message);
}

class UpdateProfileFailureState extends AuthState{
  String message;
  UpdateProfileFailureState(this.message);
}
class RegisterFailureState extends AuthState{
  String message;
  RegisterFailureState(this.message);
}class LogoutFailureState extends AuthState{
  String message;
  LogoutFailureState(this.message);
}class SendOtpFailureState extends AuthState{
  String message;
  SendOtpFailureState(this.message);
}class VerifyOtpFailureState extends AuthState{
  String message;
  VerifyOtpFailureState(this.message);
}class ResetPasswordFailureState extends AuthState{
  String message;
  ResetPasswordFailureState(this.message);
}


class GetProfileSuccessState extends AuthState{}
class UpdateProfileSuccessState extends AuthState{}
class LoginSuccessState extends AuthState{}
class RegisterSuccessState extends AuthState{}
class LogoutSuccessState extends AuthState{}
class SendOtpSuccessState extends AuthState{}
class VerifyOtpSuccessState extends AuthState{}
class ResetPasswordSuccessState extends AuthState{}