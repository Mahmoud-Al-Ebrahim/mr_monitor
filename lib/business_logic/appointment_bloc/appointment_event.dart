part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentEvent {}


class StoreAppointmentEvent extends AppointmentEvent {
  final String medicineName;
  final String dosesNum;
  final String time1;
  final String? time2;
  final String? time3;

   StoreAppointmentEvent({
    required this.medicineName,
    required this.dosesNum,
    required this.time1,
     this.time2,
     this.time3,
});
}

class TakeMedicineEvent extends AppointmentEvent {
  final String medicineId;

  TakeMedicineEvent({
    required this.medicineId,
  });
}

class DeleteAppointmentEvent extends AppointmentEvent {
  final String medicineId;

  DeleteAppointmentEvent({
    required this.medicineId,
  });
}

class GetAppointmentsEvent extends AppointmentEvent {

  GetAppointmentsEvent();
}