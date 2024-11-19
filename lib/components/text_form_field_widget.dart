import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/strings.dart';

class TextFormFieldWidget extends StatelessWidget{
  TextEditingController myController=TextEditingController();
  TextInputType type;
  IconData suffixIcon;
  bool obscure;
  bool enableTextForm;
  TextAlign textAlignDir;
  Function()? onTapFunc;
  TextFormFieldWidget(
      {this.textAlignDir=TextAlign.right,
        this.onTapFunc,
        this.obscure=false,
        this.enableTextForm=true,
        required this.myController,
        required this.type,
        required this.suffixIcon,
        super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enableTextForm,
      validator: (val)=>val!.isEmpty?ERROR_EMPTY_GENERAL:null,
      controller: myController,
      minLines: 1,
      textAlign: textAlignDir,
      onTap: onTapFunc,
      cursorColor: primaryColor,
      obscureText: obscure,
      keyboardType: type,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          suffixIcon:Icon(
            suffixIcon,
            color: primaryColor,
          ),
          floatingLabelStyle: const TextStyle(
              color: primaryColor
          )
      ),
    );
  }

}