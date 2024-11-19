import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mr_monitor3/components/btn_widget.dart';
import 'package:mr_monitor3/components/text_form_field_widget.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/pages/main_page.dart';
import 'package:mr_monitor3/presentation/pages/set_up_profile.dart';
import 'package:mr_monitor3/presentation/pages/sign_up_page.dart';
import 'package:mr_monitor3/presentation/pages/verification.dart';

import '../../core/strings.dart';
import '../../data/language_code_helper/app_localizations.dart';
import '../../util/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordShow = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/logo.png"),
                      height: 175,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("login_msg"),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("email_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFieldWidget(
                            myController: emailController,
                            type: TextInputType.emailAddress,
                            suffixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("password_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? ERROR_EMPTY_GENERAL : null,
                            controller: passwordController,
                            textAlign: TextAlign.right,
                            cursorColor: primaryColor,
                            obscureText: isPasswordShow,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordShow = !isPasswordShow;
                                    });
                                  },
                                  icon: isPasswordShow
                                      ? const Icon(
                                          Icons.visibility,
                                          color: primaryColor,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: primaryColor,
                                        ),
                                  color: primaryColor,
                                ),
                                floatingLabelStyle:
                                    const TextStyle(color: primaryColor)),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    if (emailController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                "يجب كتابة البريد الإلكتروني",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: primaryColor));
                                      return;
                                    }
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(SendOtpEvent(
                                      emailController.text,
                                    ));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerificationPage(
                                                  email: emailController.text,
                                                )));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("forget_msg"),
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                              buildWhen: (p, c) =>
                                  c is LoginSuccessState ||
                                  c is LoginFailureState ||
                                  c is LoginLoadingState,
                              builder: (context, state) {
                                if (state is LoginLoadingState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return BtnPaddingWidget(
                                    horizontalPadding: 50,
                                    onPressedFun: () {
                                      if (validateForm()) {
                                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainPage()));
                                        BlocProvider.of<AuthBloc>(context).add(
                                            AuthLoginRequest(
                                                emailController.text,
                                                passwordController.text));
                                      }
                                    },
                                    text: AppLocalizations.of(context)!
                                        .translate("login_msg"),
                                    colorText: Colors.white,
                                    backColor: primaryColor);
                              },
                              listener: (context, state) {
                                if (state is LoginFailureState) {
                                  emailController.text = '';
                                  passwordController.text = '';
                                  var snackbar = SnackBar(
                                    content: Text(
                                      state.message,
                                      style: TextStyle(
                                          fontFamily: 'dana', fontSize: 14),
                                    ),
                                    backgroundColor: Colors.black,
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }

                                if (state is LoginSuccessState) {
                                  DioProvider.setTokenFromSharedPreferences();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()),
                                      (route) => false);
                                }
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate("don't_have_an_account_msg"),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPage()));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("signup_msg"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                            ],
                          )
                        ],
                      ),
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

  bool validateForm() {
    final isValid = _formKey.currentState!.validate();
    return isValid;
  }
}
