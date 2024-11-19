import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mr_monitor3/data/models/appointments_model.dart';
import 'package:mr_monitor3/data/repository/appointment_repository.dart';

import '../../services/notifications/awesome_notification.dart';
import '../../util/get_it/get_it.dart';

part 'appointment_event.dart';

part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<AppointmentEvent>((event, emit) {});
    on<GetAppointmentsEvent>(_onGetAppointmentsEvent);
    on<StoreAppointmentEvent>(_onStoreAppointmentEvent);
    on<TakeMedicineEvent>(_onTakeMedicineEvent);
    on<DeleteAppointmentEvent>(_onDeleteAppointmentEvent);
  }
  final IAppointmentRepository _appointmentRepository = locator.get();
  Map<String , List<AppointmentModel>> medications  = {};
  Map<String , bool> alreadySchedule  = {};
  Map<String , int> countOfPillsPerMedicine  = {};


  schedule(AppointmentModel appointmentModel)async{
    List<int> data = appointmentModel.time!.split(':').map((e) => int.parse(e)).toList();
    await AwesomeNotification.createNewNotification(appointmentModel.name!, appointmentModel.id.toString(), data[0],  data[1]);
    if(appointmentModel.time2 != null){
      List<int> data = appointmentModel.time2!.split(':').map((e) => int.parse(e)).toList();
      await AwesomeNotification.createNewNotification(appointmentModel.name!, appointmentModel.id.toString(), data[0],  data[1]);
    }
    if(appointmentModel.time3 != null){
      List<int> data = appointmentModel.time3!.split(':').map((e) => int.parse(e)).toList();
      await AwesomeNotification.createNewNotification(appointmentModel.name!, appointmentModel.id.toString(), data[0],  data[1]);
    }
  }

  FutureOr<void> _onGetAppointmentsEvent(
      GetAppointmentsEvent event, Emitter<AppointmentState> emit) async {
    medications = {};
    countOfPillsPerMedicine = {};
    emit(GetAppointmentLoadingState());
    var response = await _appointmentRepository.getAppointments();
    response.fold((message) => emit(GetAppointmentFailureState(message)), (appointmentsList) {
      appointmentsList?.forEach((appointment) {
        if(countOfPillsPerMedicine[appointment.name!] == null){
          countOfPillsPerMedicine[appointment.name!] = 0;
        }
        countOfPillsPerMedicine[appointment.name!] = countOfPillsPerMedicine[appointment.name!]! + 1;
            if(medications[appointment.time] == null) {
              medications[appointment.time!] = [];
            }
              medications[appointment.time]!.add(appointment);
              schedule(appointment);
              if (appointment.time2 != null) {
                countOfPillsPerMedicine[appointment.name!] = countOfPillsPerMedicine[appointment.name!]! + 1;
                if (medications[appointment.time2] == null) {
                  medications[appointment.time2!] = [];
                }
                medications[appointment.time2]!.add(appointment);
              }
              if (appointment.time3 != null) {
                countOfPillsPerMedicine[appointment.name!] = countOfPillsPerMedicine[appointment.name!]! + 1;
                if (medications[appointment.time3] == null) {
                  medications[appointment.time3!] = [];
                }
                medications[appointment.time3]!.add(appointment);
              }
      });
      medications = Map.fromEntries(
          medications.entries.toList()..sort((e1, e2) {
            List<int> date1 = e1.key.split(':').map((e) => int.parse(e)).toList();
            List<int> date2 = e2.key.split(':').map((e) => int.parse(e)).toList();
            if(date1[0] != date2[0]) {
              return date1[0] - date2[0];
            }else{
              return date1[1] - date2[1];
            }
          }));
      emit((GetAppointmentDoneSuccessfullyState()));
    });
  }

  FutureOr<void> _onStoreAppointmentEvent(
      StoreAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(StoreAppointmentLoadingState());
    var response = await _appointmentRepository.storeAppointment(event.medicineName, event.dosesNum, event.time1, event.time2, event.time3);
    response.fold((message) => emit(StoreAppointmentFailureState(message)), (success) {
      add(GetAppointmentsEvent());
      emit((StoreAppointmentDoneSuccessfullyState()));
    });

  }

  FutureOr<void> _onTakeMedicineEvent(
      TakeMedicineEvent event, Emitter<AppointmentState> emit) async {
    print('wwwwwwwwwwwwwwwwwwwww');
    emit(TakeMedicineLoadingState());
    var response = await _appointmentRepository.takeMedicine(event.medicineId);
    response.fold((message) => emit(TakeMedicineFailureState(message)), (success) {
      add(GetAppointmentsEvent());
      emit((TakeMedicineDoneSuccessfullyState()));
    });
  }

  FutureOr<void> _onDeleteAppointmentEvent(
      DeleteAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(DeleteAppointmentLoadingState());
    var response = await _appointmentRepository.deleteAppointment(event.medicineId);
    response.fold((message) => emit(DeleteAppointmentFailureState(message)), (success) {
      add(GetAppointmentsEvent());
      emit((DeleteAppointmentDoneSuccessfullyState()));
    });
  }
}
