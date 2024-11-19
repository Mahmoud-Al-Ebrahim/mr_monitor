import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/doctor_model.dart';
import '../../data/repository/doctor_repository.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository doctorRepository;
  List<Doctor> doctors=[];
  DoctorCubit(this.doctorRepository) : super(DoctorInitial());
  List<Doctor> getAllDoctors(){
    doctorRepository.getAllDoctors().then((doctors) {
      emit(DoctorsLoaded(doctors));
      this.doctors=doctors;
    });
    return doctors;
  }
}