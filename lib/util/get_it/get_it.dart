import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mr_monitor3/data/data_source/appointment_data_source.dart';
import 'package:mr_monitor3/data/data_source/data_source_auth.dart';
import 'package:mr_monitor3/data/repository/appointment_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/auth_repository.dart';
import '../dio.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  await locator.reset(dispose: true);
  await _initComponents();
  await _initDatasoruces();
  await _initRepositories();
}

Future<void> _initComponents() async {
  locator.registerSingleton<Dio>(DioProvider.createDioWithoutHeader());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _initDatasoruces() async {
  locator.registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator.registerFactory<IAppointmentDatasource>(() => AppointmentRemote());
}

Future<void> _initRepositories() async{
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<IAppointmentRepository>(() => AppointmentRepository());
}