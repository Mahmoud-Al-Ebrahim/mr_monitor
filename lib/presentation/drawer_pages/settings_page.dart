import 'package:flag/flag_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business_logic/lang_cubit/locale_cubit.dart';
import '../../data/language_code_helper/app_localizations.dart';
//import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: primaryColor,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Center(
             child: Text(
          AppLocalizations.of(context)!.translate("general_msg"),
               style: TextStyle(
                 color: primaryColor,
                 fontSize: 25,
                 fontWeight: FontWeight.bold
               ),
             ),
           ),
           Container(
             height: 2,
             width: double.infinity,
             color: Colors.grey[400],
           ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.language,color: Colors.grey,),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate("lang_msg"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      BlocProvider.of<LocaleCubit>(context).changeLanguage("en");
                    },
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Flag.fromString('US', height: 50, width: 50, fit: BoxFit.cover,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: ()async{
                      BlocProvider.of<LocaleCubit>(context).changeLanguage("en");

                    },
                    child: Text(
    AppLocalizations.of(context)!.translate("english_msg"),
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    BlocProvider.of<LocaleCubit>(context).changeLanguage("ar");
                  },
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Flag.fromString('SY', height: 50, width: 50, fit: BoxFit.cover,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: ()async{
                    BlocProvider.of<LocaleCubit>(context).changeLanguage("ar");

                  },
                  child: Text(
                    AppLocalizations.of(context)!.translate("arabic_msg"),
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
              SizedBox(
                height: 20,
              ),
           Row(
             children: [
               InkWell(
                 onTap: (){
                   BlocProvider.of<LocaleCubit>(context).changeLanguage("de");
                 },
                 child: Container(
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   child: Flag.fromString('DE', height: 50, width: 50, fit: BoxFit.cover,),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30),
                   ),
                 ),
               ),
               SizedBox(
                 width: 40,
               ),
               InkWell(
                 onTap: ()async{
                   BlocProvider.of<LocaleCubit>(context).changeLanguage("de");
                 },
                 child: Text(
                   AppLocalizations.of(context)!.translate("germany_msg"),
                   style: TextStyle(
                       fontSize: 20
                   ),
                 ),
               ),
             ],
           ),
              Spacer(),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.translate("help_msg"),
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text( AppLocalizations.of(context)!.translate("contact_msg"), style: TextStyle(
                      color: Colors.black,

                      fontSize: 20
                  ),),
                  SizedBox(
                    width: 5,
                  ),
                  Text("0949036009",style: TextStyle(fontSize: 18,color: Colors.grey[700]),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(AppLocalizations.of(context)!.translate("how_msg"), style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),),
                 Icon(Icons.arrow_downward,color:primaryColor,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text:TextSpan(
                    text: "https://youtu.be/UMN1zILdLTs?si=A150erCylfECt_ye",
                    style: TextStyle(
                      color: primaryColor
                    ),
                   // recognizer: TapGestureRecognizer()..onTap=()async{
                      //Uri url=Uri.parse("https://youtu.be/UMN1zILdLTs?si=A150erCylfECt_ye");
//                       if(await canLaunchUrl(url)){
//                         await launchUrl(url);
//                       }else{
// throw "Cannot load url";
//                       }
                 //   }
                  )
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }

}