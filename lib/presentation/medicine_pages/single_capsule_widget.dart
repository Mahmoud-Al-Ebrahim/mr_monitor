import 'package:flutter/material.dart';

import '../../core/colors.dart';

class SingleCapsuleWidget extends StatelessWidget{
  String name;
  String countPerDay;

  SingleCapsuleWidget({super.key,required this.name,required this.countPerDay});
  @override
  Widget build(BuildContext context) {
  return Container(
    width:double.infinity ,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[200],
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        Image(
          image: AssetImage("assets/images/single_capsule.png"),fit: BoxFit.cover,
          height: 100,
        ),
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$countPerDay pill once per day",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 30,
              color: primaryColor,
            ),
        ),
      ],
    ),

  );
  }

}