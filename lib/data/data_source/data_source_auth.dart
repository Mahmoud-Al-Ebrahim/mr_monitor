
import 'dart:io';

import 'package:dio/dio.dart';

import '../../util/auth_manager.dart';
import '../../util/dio.dart';
import '../../util/exception.dart';
import '../models/user_model.dart';

abstract class IAuthenticationDatasource {
  Future<UserModel?> register(String name,String number,String email, String password,String confirmPassword,String birthday,String address );
  Future<bool> updateProfile(String name,String number,String email,String birthday,String address, String userId );
  Future<UserModel?> login(String email,String password ,String fcmToken );
  Future<bool> logout();
  Future<User?> getProfile();
  Future<bool> sendOtp(String email);
  Future<bool> verifyOtp(String code , String email);
  Future<bool> resetPassword(String password , String email);
}

class AuthenticationRemote extends IAuthenticationDatasource {
   Dio _dio = DioProvider.createDioWithoutHeader();

   initDio(){
     print('hello');
     if(DioProvider.token != null){
       _dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer ${DioProvider.token}";
     }
     print(_dio.options.headers);
   }
  @override
  Future<UserModel?> register(String name, String number, String email, String password, String confirmPassword, String birthday, String address) async {
    initDio();
    try {
      final response = await _dio.post('auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'Companion_phone':number,
        'birthday':birthday,
        'address':birthday,
      });
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        AuthManager.saveToken(user.authorisation!.token!);
        return user;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print(ex);
      //throw ApiException(ex.response?.statusCode, ex.response?.data['message'],
          //response: ex.response);
    } catch (ex) {
      print(ex);
      //throw ApiException(0, 'unknown erorr');
    }
    return null;
  }

  @override
  Future<UserModel?> login(String email, String password , String fcmToken) async {
    initDio();

     try {
      final response =
      await _dio.post('auth/login', data: {
        'email': email,
        'password': password,
        'fcm-token' : fcmToken
      });
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        AuthManager.saveToken(user.authorisation!.token!);
        return user;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print('DioErrorDioErrorDioErrorDioErrorDioError');

      //throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      print(ex.toString());
      //throw ApiException(0, 'unknown error');
    }
    return null;
  }

  @override
  Future<bool> logout() async{
    initDio();

     try {
      final response =
      await _dio.post('auth/logout',);
      if (response.statusCode == 200) {
       return true;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print(ex.toString());
      print('DioErrorDioErrorDioErrorDioErrorDioError');

      //throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      print(ex.toString());
      //throw ApiException(0, 'unknown error');
    }
    return false;
  }

  @override
  Future<bool> resetPassword(String password , String email) async{
    initDio();

     try {
      final response =
      await _dio.post('auth/$email/reset_password',data: {
        'password' : password
      });
      if (response.statusCode == 200) {
        return true;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print('DioErrorDioErrorDioErrorDioErrorDioError');

      //throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      print(ex.toString());
      //throw ApiException(0, 'unknown error');
    }
    return false;
  }

  @override
  Future<bool> sendOtp(String email) async{
    initDio();

     try {
      final response =
      await _dio.get('auth/$email/send_code');
      if (response.statusCode == 200) {
        return true;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print('DioErrorDioErrorDioErrorDioErrorDioError');

      //throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      print(ex.toString());
      //throw ApiException(0, 'unknown error');
    }
    return false;
  }

  @override
  Future<bool> verifyOtp(String code , String email) async{
    initDio();

     try {
      final response =
      await _dio.post('auth/$email/check_code',data: {
        'code' : code
      });
      if (response.statusCode == 200) {
        return true;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print('DioErrorDioErrorDioErrorDioErrorDioError');

      //throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      print(ex.toString());
      //throw ApiException(0, 'unknown error');
    }
    return false;
  }

  @override
  Future<User?> getProfile() async{
    initDio();

     try {
      final response =
      await _dio.get('auth/me');
      if (response.statusCode == 200) {
        User user = User.fromJson(response.data[0]);
        return user;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print(ex);
      print('DioErrorDioErrorDioErrorDioErrorDioError');

    } catch (ex) {
      print(ex.toString());
    }
    return null;
  }

  @override
  Future<bool> updateProfile(String name, String number, String email, String birthday, String address , String userId) async{
    initDio();

     try {
      final response = await _dio.post('/auth/$userId/update', data: {
        'name': name,
        'email': email,
        'Companion_phone':number,
        'birthday':birthday,
        'address':birthday,
      });
      if (response.statusCode == 200) {
        return true;
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      print(ex);
      //throw ApiException(ex.response?.statusCode, ex.response?.data['message'],
      //response: ex.response);
    } catch (ex) {
      print(ex);
      //throw ApiException(0, 'unknown erorr');
    }
    return false;
  }
  // Future<String> sendCode(String email) async {
  //   try {
  //     final response =
  //     await _dio.get('auth/$email/send_code',);
  //     if (response.statusCode == 200) {
  //      return
  //     }
  //     // ignore: deprecated_member_use
  //   } on DioError catch (ex) {
  //     print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
  //
  //     throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
  //   } catch (ex) {
  //     print(ex.toString());
  //     throw ApiException(0, 'unknown error');
  //   }
  //   return '';
  // }
  //
  // Future<void> checkCode(String code) async {
  //   try {
  //     final response =
  //     await _dio.post('auth/login', data: {
  //       'email': email,
  //       'password': password,
  //       'fcm-token' : fcmToken
  //     });
  //     if (response.statusCode == 200) {
  //       UserModel user = UserModel.fromJson(response.data);
  //       AuthManager.saveToken(user.authorisation!.token!);
  //       return user;
  //     }
  //     // ignore: deprecated_member_use
  //   } on DioError catch (ex) {
  //     print('DioErrorDioErrorDioErrorDioErrorDioError');
  //
  //     throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
  //   } catch (ex) {
  //     print(ex.toString());
  //     throw ApiException(0, 'unknown error');
  //   }
  //   return null;
  // }

}