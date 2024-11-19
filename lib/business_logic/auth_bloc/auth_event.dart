part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  String email;
  String password;

  AuthLoginRequest(this.email, this.password);
}

class AuthRegisterRequest extends AuthEvent {
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;
  String birthday;
  String address;

  AuthRegisterRequest(this.name, this.phone, this.email, this.password,
      this.confirmPassword, this.birthday, this.address);
}

class GetProfile extends AuthEvent {
  GetProfile();
}

class UpdateProfileRequest extends AuthEvent {
  String name;
  String phone;
  String email;
  String birthday;
  String address;

  UpdateProfileRequest(
      this.name, this.phone, this.email, this.birthday, this.address);
}

class VerifyOtpEvent extends AuthEvent {
  String email;
  String code;

  VerifyOtpEvent(this.email, this.code);
}

class LogoutEvent extends AuthEvent {}

class SendOtpEvent extends AuthEvent {
  String email;

  SendOtpEvent(this.email);
}

class ResetPasswordEvent extends AuthEvent {
  String email;
  String password;

  ResetPasswordEvent(this.email, this.password);
}
