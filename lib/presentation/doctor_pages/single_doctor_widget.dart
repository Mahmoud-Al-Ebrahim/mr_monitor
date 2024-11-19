import 'package:flutter/material.dart';

import '../../data/models/doctor_model.dart';

class SingleDoctorWidget extends StatelessWidget{
  final Doctor doctor;

  const SingleDoctorWidget({super.key,required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],   boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5,
          offset: const Offset(0,
              2), // Shadow position
        ),
      ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10,),
        child: Row(
          children: [
            Image(
              image: AssetImage("assets/images/doctor_photo.png"),
              height: 115,

            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  doctor.doctorName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      doctor.doctorSpecialize ?? 'Not Specific'
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}