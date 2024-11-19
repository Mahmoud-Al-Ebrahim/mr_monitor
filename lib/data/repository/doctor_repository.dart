import '../models/doctor_model.dart';
import '../web_services/doctor_web_service.dart';

class DoctorRepository{
  final DoctorWebServices doctorWebServices;
  DoctorRepository(this.doctorWebServices);
  Future<List<Doctor>> getAllDoctors()async{
    final doctors=await doctorWebServices.getAllDoctors();
    return doctors.map((doctor) => Doctor.fromJson(doctor)).toList();
  }
}