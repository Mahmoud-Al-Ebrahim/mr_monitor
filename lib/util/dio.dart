import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
   static Dio createDioWithoutHeader() {

    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://render-ecommerce-4e71.onrender.com/api/',
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
      contentType: "application/json",
      responseType: ResponseType.json,
    ));

    return dio;
  }
  static String? token ;

   static setTokenFromSharedPreferences() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     token = sharedPreferences.getString('access_token');
   }
}