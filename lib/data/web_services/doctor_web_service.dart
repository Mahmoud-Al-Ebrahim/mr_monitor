import 'package:dio/dio.dart';
class DoctorWebServices{
  late Dio dio;
  DoctorWebServices(){
    BaseOptions options=BaseOptions(
      baseUrl: "https://render-ecommerce-4e71.onrender.com/api/",
      receiveDataWhenStatusError: true,
      connectTimeout:const Duration(seconds: 20) ,
      receiveTimeout: const Duration(seconds: 20) ,
    );
    dio=Dio(options);
  }
  Future<List<dynamic>> getAllDoctors()async{
    try{
      Response response=await dio.get("doctors/index");
      print(response.data.toString());
      return response.data;
    }
    catch(e){
      print(e.toString());
      return [];
    }
  }
}
