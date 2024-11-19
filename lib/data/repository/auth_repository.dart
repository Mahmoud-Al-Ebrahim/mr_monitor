import 'package:either_dart/either.dart';

import '../../util/exception.dart';
import '../../util/get_it/get_it.dart';
import '../data_source/data_source_auth.dart';
import '../models/user_model.dart';


abstract class IAuthRepository {
  Future<Either<String,UserModel?>> register(String name, String number, String email, String password, String confirmPassword, String birthday, String address);
  Future<Either<String,bool>> updateProfile(String name, String number, String email, String birthday, String address, String userId);
  Future<Either<String,UserModel?>> login(String email, String password, String fcmToken);

  Future<Either<String,bool>> logout();
  Future<Either<String,User?>> getProfile();
  Future<Either<String,bool>> sendOtp(String email);
  Future<Either<String,bool>> verifyOtp(String code , String email);
  Future<Either<String,bool>> resetPassword(String password , String email);
}

class AuthenticationRepository extends IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();
  @override
  Future<Either<String, UserModel?>> login(String email, String password, String fcmToken) async {
    try {
      UserModel? user = await _datasource.login(email, password,fcmToken);
      if (user != null) {
        return Right(user);
      } else {
        return Left('error');
      }
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }

  @override
  Future<Either<String, UserModel?>> register(String name, String number, String email, String password, String confirmPassword, String birthday, String address) async {
      UserModel? user = await _datasource.register(name, number, email, password,confirmPassword,birthday,address);
      if(user != null) {
        return Right(user);
      }
    else{
      return const Left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, bool>> logout() async{
    bool success = await _datasource.logout();
    if(success) {
      return const Right(true);
    }
    else{
      return const Left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, bool>> resetPassword(String password , String email) async{
    bool success = await _datasource.resetPassword(password , email);
    if(success) {
      return const Right(true);
    }
    else{
      return const Left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, bool>> sendOtp(String email) async{
    bool success = await _datasource.sendOtp(email);
    if(success) {
      return const Right(true);
    }
    else{
      return const Left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, bool>> verifyOtp(String code , String email) async{
    bool success = await _datasource.verifyOtp(code , email);
    if(success) {
      return const Right(true);
    }
    else{
      return const Left('Wrong Code');
    }
  }

  @override
  Future<Either<String, User?>> getProfile() async{
    User? user = await _datasource.getProfile();
    if(user != null) {
      return Right(user);
    }
    else{
      return const Left('Something Went Wrong');
    }
  }

  @override
  Future<Either<String, bool>> updateProfile(String name, String number, String email, String birthday, String address, String userId) async{
    bool success = await _datasource.updateProfile(name, number, email,birthday,address, userId);
    if(success) {
      return Right(success);
    }
    else{
      return const Left('Something Went Wrong');
    }
  }
}