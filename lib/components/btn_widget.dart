import 'package:flutter/material.dart';

import '../core/colors.dart';

class BtnPaddingWidget extends StatelessWidget{
  final double horizontalPadding;
  final Function() onPressedFun;
  final String text;
  final Color colorText;
  final Color backColor;
  final double verticalPadding;
  const BtnPaddingWidget({super.key, required this.horizontalPadding, required this.onPressedFun, required this.text, required this.colorText, required this.backColor,this.verticalPadding=0 });
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
      child: InkWell(
        onTap:onPressedFun ,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryColor),
          ),
          child: Center(
              child: Text(
                  text,
                  style:TextStyle(
                      color: colorText,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
        ),
    );
  }

}