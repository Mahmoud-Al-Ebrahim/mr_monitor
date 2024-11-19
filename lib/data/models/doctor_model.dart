class Doctor{
  late int doctorId;
  late String doctorName;
  late String doctorAddress;
  late String doctorPhoneNumber;
  String? doctorSpecialize;
  String? doctorCertificate;
  Doctor.fromJson(Map<String,dynamic>json){
    doctorId=json["id"];
    doctorName=json["name"];
    doctorAddress=json["address"];
    doctorPhoneNumber=json["Companion_phone"];
    doctorSpecialize=json["specialist"];
     doctorCertificate=json["certificate"];
  }
}