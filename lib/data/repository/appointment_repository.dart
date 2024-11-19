import 'package:either_dart/either.dart';

import '../../util/exception.dart';
import '../../util/get_it/get_it.dart';
import '../data_source/appointment_data_source.dart';
import '../models/appointments_model.dart';
import '../models/user_model.dart';

abstract class IAppointmentRepository {
  Future<Either<String,List<AppointmentModel>?>> getAppointments();
  Future<Either<String,bool>> storeAppointment(String medicineName , String dosesNum , String time1 , String? time2 , String? time3);
  Future<Either<String,bool>> takeMedicine(String appointmentId);
  Future<Either<String,bool>> deleteAppointment(String appointmentId);
}

class AppointmentRepository extends IAppointmentRepository {
  final IAppointmentDatasource _datasource = locator.get();

  @override
  Future<Either<String, bool>> deleteAppointment(String appointmentId)async {
    try {
      bool success = await _datasource.deleteAppointment(appointmentId);
      if (success) {
        return Right(success);
      } else {
        return Left('error');
      }
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }

  @override
  Future<Either<String, List<AppointmentModel>?>> getAppointments() async{
    try {
      List<AppointmentModel>? appointments = await _datasource.getAppointments();
      if (appointments != null) {
        return Right(appointments);
      } else {
        return Left('error');
      }
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }

  @override
  Future<Either<String, bool>> storeAppointment(String medicineName, String dosesNum, String time1, String? time2, String? time3)async {
    try {
      bool success = await _datasource.storeAppointment(medicineName , dosesNum , time1 , time2 , time3);
      if (success) {
        return Right(success);
      } else {
        return Left('error');
      }
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }

  @override
  Future<Either<String, bool>> takeMedicine(String appointmentId) async{
    try {
      bool success = await _datasource.takeMedicine(appointmentId);
      if (success) {
        return Right(success);
      } else {
        return Left('error');
      }
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }
}
