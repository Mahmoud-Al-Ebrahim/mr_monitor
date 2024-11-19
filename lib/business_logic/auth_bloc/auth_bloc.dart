import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:mr_monitor3/util/get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository = locator.get();

  UserModel? userModel;
  User? userData;

  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(LoginLoadingState());
      var response = await _authRepository.login(
          event.email, event.password, '121ert-fthd');
      response.fold((message) {
        emit(LoginFailureState(message));
      }, (user) {
        userModel = user;
        userData = userModel?.user;
        print('token ${userModel!.authorisation!.token}');
        emit(LoginSuccessState());
      });
    });
    on<AuthRegisterRequest>((event, emit) async {
      emit(RegisterLoadingState());
      var response = await _authRepository.register(event.name, event.phone,
          event.email, event.password, event.confirmPassword, event.birthday , event.address);
      response.fold((message) => emit(RegisterFailureState(message)), (user) {
        userModel = user;
        userData = userModel?.user;
        print('token ${userModel!.authorisation!.token}');
            emit(RegisterSuccessState());
      });
    });
    on<UpdateProfileRequest>(_onUpdateProfileRequest);
    on<GetProfile>(_onGetProfile);
    on<LogoutEvent>(_onLogoutEvent);
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
  }

  void removeToken()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('access_token');
  }
  FutureOr<void> _onLogoutEvent(LogoutEvent event,
      Emitter<AuthState> emit) async {
    removeToken();
    await getItInit();
    emit(LogoutLoadingState());
    var response = await _authRepository.logout();
    response.fold((message) => emit(LogoutFailureState(message)), (success) {
      emit(LogoutSuccessState());
    });
  }

  FutureOr<void> _onSendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async{
    emit(SendOtpLoadingState());
    var response = await _authRepository.sendOtp(event.email);
    response.fold((message) => emit(SendOtpFailureState(message)), (success) {
      emit(SendOtpSuccessState());
    });
  }

  FutureOr<void> _onVerifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async{
    emit(VerifyOtpLoadingState());
    var response = await _authRepository.verifyOtp(event.code , event.email);
    response.fold((message) => emit(VerifyOtpFailureState(message)), (success) {
      emit(VerifyOtpSuccessState());
    });
  }

  FutureOr<void> _onResetPasswordEvent(ResetPasswordEvent event, Emitter<AuthState> emit) async{
    emit(ResetPasswordLoadingState());
    var response = await _authRepository.resetPassword(event.password , event.email);
    response.fold((message) => emit(ResetPasswordFailureState(message)), (success) {
      emit(ResetPasswordSuccessState());
    });
  }

  FutureOr<void> _onGetProfile(GetProfile event, Emitter<AuthState> emit) async{
    if(userData != null) return ;
    emit(GetProfileLoadingState());
    var response = await _authRepository.getProfile();
    response.fold((message) => emit(GetProfileFailureState(message)), (user) {
      userData = user;
      print(userData);
      emit(GetProfileSuccessState());
    });
  }

  FutureOr<void> _onUpdateProfileRequest(UpdateProfileRequest event, Emitter<AuthState> emit) async{
    emit(UpdateProfileLoadingState());
    var response = await _authRepository.updateProfile(event.name, event.phone,
        event.email, event.birthday , event.address , userData!.id.toString());
    response.fold((message) => emit(UpdateProfileFailureState(message)), (success) {
      print(DateTime.tryParse(event.birthday));
      userData = User(
        id: userData!.id,
        name: event.name,
        companionPhone: event.phone,
        email: event.email,
        address: event.address,
        birthday: DateTime.tryParse(event.birthday),
      );
      emit(UpdateProfileSuccessState());
    });
  }
}
