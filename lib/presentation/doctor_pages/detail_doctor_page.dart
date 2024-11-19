import 'package:flutter/material.dart';
import 'package:mr_monitor3/components/btn_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/colors.dart';
import '../../data/language_code_helper/app_localizations.dart';
import '../../data/models/doctor_model.dart';

class DetailDoctorPage extends StatelessWidget{
  final Doctor doctor;

  const DetailDoctorPage({super.key,required this.doctor});


  void openWhatsApp() async {
    final phoneNumber = doctor.doctorPhoneNumber; // Replace with the target phone number
    const message = 'Help Me'; // Replace with your message
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size ;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
             height: size.height * 0.33,
             child: Stack(
               children: [
                Center(child: Image(image: AssetImage("assets/images/doctor_photo.png"),fit: BoxFit.cover,)),
                 IconButton(
                     onPressed: () => Navigator.of(context).pop(),
                     icon: const Icon(
                       Icons.arrow_back_ios_new_outlined,
                       size: 30,
                       color: primaryColor,
                     )),
               ],
             ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.67 - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    60,
                  ),
                  topLeft: Radius.circular(
                    60,
                  ),
                ),
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
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 30,
                  right: 30
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height * 0.55 ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                doctor.doctorName,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              doctor.doctorSpecialize ?? 'Not Specific',
                              style: TextStyle(
                                fontSize: 17
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate("address_msg"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                               doctor.doctorAddress,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700]
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate("phone_msg"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                             doctor.doctorPhoneNumber,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700]
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.translate("certificates_msg"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                            doctor.doctorCertificate ?? 'Not Specific',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700]
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                        BtnPaddingWidget(
                            horizontalPadding:50 ,
                            onPressedFun:(){
                              openWhatsApp();
                            } ,
                            text: AppLocalizations.of(context)!.translate("chat_msg"),
                            colorText:Colors.white ,
                            backColor:primaryColor
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}