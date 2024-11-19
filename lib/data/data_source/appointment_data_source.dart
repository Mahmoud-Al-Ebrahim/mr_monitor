

import 'dart:io';

import 'package:dio/dio.dart';

import '../../util/dio.dart';
import '../models/appointments_model.dart';

abstract class IAppointmentDatasource {
  Future<List<AppointmentModel>?> getAppointments();
  Future<bool> storeAppointment(String medicineName , String dosesNum , String time1 , String? time2 , String? time3);
  Future<bool> takeMedicine(String appointmentId);
  Future<bool> deleteAppointment(String appointmentId);
}

class AppointmentRemote extends IAppointmentDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();
  initDio(){
    if(DioProvider.token != null){
      _dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer ${DioProvider.token}";
    }
    print(_dio.options.headers);
  }

  @override
  Future<bool> deleteAppointment(String appointmentId) async{
    initDio();
    try {
      final response =
          await _dio.delete('appointment/$appointmentId/destroy',);
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
  Future<List<AppointmentModel>?> getAppointments() async{
    initDio();
    try {
      final response =
          await _dio.get('appointment/index');
      if (response.statusCode == 200) {
        print(response.data);
        final List<dynamic> data = response.data ;
        return response.data == null ? [] : data.map((appointment)=> AppointmentModel.fromJson(appointment)).toList();
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
    return null;
  }

  @override
  Future<bool> storeAppointment(String medicineName, String dosesNum, String time1, String? time2, String? time3) async{
    initDio();
    try {
      final response =
          await _dio.post('appointment/store',data: {
            'name' :medicineName,
            'doses_num' :dosesNum,
            'time' :time1,
            'time2' :time2,
            'time3' :time3,
          });
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
  Future<bool> takeMedicine(String appointmentId) async{
    initDio();
    try {
      final response =
          await _dio.get('appointment/$appointmentId/take_medicine',);
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
}
