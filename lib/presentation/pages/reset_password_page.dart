import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/pages/main_page.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../components/btn_widget.dart';
import '../../components/text_form_field_widget.dart';
import '../../util/show_snack_bar.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
  String email;
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) => MainPage()));
        }
        if (state is ResetPasswordFailureState) {
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
                    TextFormFieldWidget(
                      myController: passwordController,
                      type: TextInputType.visiblePassword,
                      obscure: true,
                      suffixIcon: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return BtnPaddingWidget(
                            horizontalPadding: 20,
                            onPressedFun: () {
                              if (passwordController.text.length < 8) {
                                showMessage(context,
                                    'Password must be at least 8 characters');
                                return;
                              }
                              BlocProvider.of<AuthBloc>(context).add(
                                  ResetPasswordEvent(
                                      widget.email, passwordController.text));
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
