part of 'doctor_cubit.dart';

@immutable
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorsLoaded extends DoctorState{
  final List<Doctor> doctors;
  DoctorsLoaded(this.doctors);
}
