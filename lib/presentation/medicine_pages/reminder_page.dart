import 'package:flutter/material.dart';
import 'package:mr_monitor3/components/btn_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../core/colors.dart';
import '../../data/language_code_helper/app_localizations.dart';

class ReminderPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             IconButton(
                 onPressed: () => Navigator.of(context).pop(),
                 icon: const Icon(
                   Icons.arrow_back_ios_new_outlined,
                   size: 30,
                   color: primaryColor,
                 )),
             Center(child: Image(image: AssetImage("assets/images/capsule2.png"))),
             SizedBox(
               height: 40,
             ),
             Center(
               child: Text(
                 "Vitamin C",
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 40
                 ),
               ),
             ),
             Text(
               "4/14 days Done",
               style: TextStyle(
                 color: Colors.grey,
                 fontSize: 16,
                 fontWeight: FontWeight.w600
               ),
             ),
             SizedBox(
               height: 10,
             ),
             LinearPercentIndicator(
               padding: EdgeInsets.symmetric(horizontal: 0),
               animation: true,
               animationDuration: 1000,
               lineHeight: 5,
               percent: .3,
               progressColor: primaryColor,
               backgroundColor: Colors.grey[300],
             ),
             SizedBox(
               height: 20,
             ),
             Text(
                 "Program",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 22
               ),
             ),
             SizedBox(
               height: 30,
             ),
             BtnPaddingWidget(
                 horizontalPadding:40 ,
                 onPressedFun:(){} ,
                 text: "1 Pill every day at 8:00",
                 colorText:Colors.white ,
                 backColor:primaryColor
             ),
             SizedBox(
               height: 100,
             ),
             Expanded(
               child: Row(
                 children: [
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(color: primaryColor),
                     ),
                     width:double.infinity,
                     height: 50,
                       child: Center(
                         child: Text(
                           AppLocalizations.of(context)!.translate("skip_msg"),
                           style:TextStyle(
                               color: primaryColor,
                               fontWeight: FontWeight.bold,
                               fontSize: 20),
                         ),
                       )
                   ),
                 ),
                   SizedBox(
                     width: 25,
                   ),
                   Expanded(
                     child: Container(
                         decoration: BoxDecoration(
                           color: primaryColor,
                           borderRadius: BorderRadius.circular(20),
                           border: Border.all(color: primaryColor),
                         ),
                         width:double.infinity,
                         height: 50,
                         child: Center(
                           child: Text(
                             AppLocalizations.of(context)!.translate("done_msg"),
                             style:TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20),
                           ),
                         )
                     ),
                   ),
                 ],
               ),
             ),
           //  BtnPaddingWidget(horizontalPadding:100 , onPressedFun:(){} , text:"Skip", colorText:primaryColor , backColor:Colors.white ),
           ],
         ),
       ),
     ),
   );
  }

}