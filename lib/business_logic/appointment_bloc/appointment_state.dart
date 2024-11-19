part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class GetAppointmentLoadingState extends AppointmentState {}

class DeleteAppointmentLoadingState extends AppointmentState {}

class StoreAppointmentLoadingState extends AppointmentState {}

class TakeMedicineLoadingState extends AppointmentState {}

class GetAppointmentDoneSuccessfullyState extends AppointmentState {}

class StoreAppointmentDoneSuccessfullyState extends AppointmentState {}

class DeleteAppointmentDoneSuccessfullyState extends AppointmentState {}

class TakeMedicineDoneSuccessfullyState extends AppointmentState {}

class GetAppointmentFailureState extends AppointmentState {
  final String message;

  GetAppointmentFailureState(this.message);
}

class DeleteAppointmentFailureState extends AppointmentState {
  final String message;

  DeleteAppointmentFailureState(this.message);
}

class StoreAppointmentFailureState extends AppointmentState {
  final String message;

  StoreAppointmentFailureState(this.message);
}

class TakeMedicineFailureState extends AppointmentState {
  final String message;

  TakeMedicineFailureState(this.message);
}
