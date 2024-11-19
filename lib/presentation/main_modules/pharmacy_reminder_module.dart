import 'package:flutter/material.dart';
import 'package:mr_monitor3/components/btn_widget.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/medicine_pages/capsule_plan.dart';

import '../../data/language_code_helper/app_localizations.dart';

class PharmacyReminderModule extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: SafeArea(
       child: Column(
         children: [
           Spacer(
             flex: 1,
           ),
           Center(child: Image(image: AssetImage("assets/images/capsule2.png"))),
           Spacer(
             flex: 1,
           ),
           Text(
             AppLocalizations.of(context)!.translate("modification_msg"),
             style: TextStyle(
               fontSize: 30,
               fontWeight: FontWeight.bold
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             width: 350,
             child: Center(
               child: Text(
                 AppLocalizations.of(context)!.translate("description_reminder_msg"),
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.grey,
                   fontSize: 18
                 ),
               ),
             ),
           ),
           Spacer(
             flex: 2,
           ),
           BtnPaddingWidget(
               horizontalPadding:50 ,
               onPressedFun: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CapsulePlanPage()));
               },
               text:  AppLocalizations.of(context)!.translate("get_started_msg"),
               colorText:Colors.white ,
               backColor:primaryColor
           ),
           Spacer(),
         ],
       ),
     ),
   );
  }

}