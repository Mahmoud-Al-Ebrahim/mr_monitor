import 'package:flutter/material.dart';
import 'package:mr_monitor3/components/btn_widget.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/main_modules/heart_beats_module.dart';
import 'package:mr_monitor3/presentation/pages/log_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/dio.dart';
import 'main_page.dart';

class GetStartedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
    body: Column(
      children: [
        Spacer(
          flex: 3,
        ),
        Image(image: AssetImage("assets/images/getStarted.png")),
        SizedBox(
          height: 50,
        ),
        Text("Get connect our best Doctors",
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
          fontWeight: FontWeight.bold
        ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
        width: 220,
        child: Text("Get a medical opinion from our expert team",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize:16
          ),
          ),
        ),
        Spacer(
          flex: 5,
        ),
        BtnPaddingWidget(
            horizontalPadding:50 ,
            onPressedFun:() async{
              DioProvider.setTokenFromSharedPreferences();
              SharedPreferences sharedPreference = await SharedPreferences.getInstance();
              bool thereIsToken = sharedPreference.getString('access_token') != null ;
              print('token:     ${sharedPreference.getString('access_token')}');
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> thereIsToken ?  MainPage() : LoginPage()));
            } ,
            text:"Get Started" ,
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