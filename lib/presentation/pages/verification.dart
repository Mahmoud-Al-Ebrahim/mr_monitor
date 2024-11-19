import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/pages/reset_password_page.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../components/btn_widget.dart';
import '../../util/show_snack_bar.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
  String email;
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => ResetPasswordPage(
                    email: widget.email,
                  )));
        }
        if (state is SendOtpFailureState) {
          showMessage(context, state.message);
        }
        if (state is VerifyOtpFailureState) {
          showMessage(context, state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Image(
                        image: AssetImage("assets/images/verification.png")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Verification",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        "enter the 4-digit that we have send via the phone number ******@gmail.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PinCodeTextField(
                      controller: pinCodeController,
                      maxLength: 4,
                      pinBoxWidth: 70,
                      keyboardType: TextInputType.number,
                      pinBoxRadius: 15,
                      defaultBorderColor: primaryColor,
                      hasTextBorderColor: primaryColor,
                      pinTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have a code?",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SendOtpEvent(
                                widget.email,
                              ));
                            },
                            child: const Text(
                              "Re-Send",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is VerifyOtpLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return BtnPaddingWidget(
                            horizontalPadding: 20,
                            onPressedFun: () {
                              if (pinCodeController.text.length < 4) {
                                showMessage(
                                    context, 'Please Enter the full code');
                                return;
                              }
                              BlocProvider.of<AuthBloc>(context).add(
                                  VerifyOtpEvent(
                                      widget.email, pinCodeController.text));
                            },
                            text: "Continue",
                            colorText: Colors.white,
                            backColor: primaryColor);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
