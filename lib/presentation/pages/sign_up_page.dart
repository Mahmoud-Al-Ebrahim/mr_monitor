import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mr_monitor3/presentation/pages/main_page.dart';

import '../../business_logic/auth_bloc/auth_bloc.dart';
import '../../components/btn_widget.dart';
import '../../components/text_form_field_widget.dart';
import '../../core/colors.dart';
import '../../data/language_code_helper/app_localizations.dart';
import '../../util/dio.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordConfirmationController =
      TextEditingController();

  final TextEditingController birthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/logo.png"),
                      height: 175,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("signup_msg"),
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
                                  .translate("name_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFieldWidget(
                            myController: nameController,
                            type: TextInputType.name,
                            suffixIcon: Icons.person,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("phone_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFieldWidget(
                            myController: phoneController,
                            type: TextInputType.number,
                            suffixIcon: Icons.phone,
                          ),
                          SizedBox(
                            height: 15,
                          ),
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
                                  .translate("email_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFieldWidget(
                            myController: addressController,
                            type: TextInputType.emailAddress,
                            suffixIcon: Icons.location_on,
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
                          TextFormFieldWidget(
                            myController: passwordController,
                            type: TextInputType.visiblePassword,
                            obscure: true,
                            suffixIcon: Icons.remove_red_eye,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("password_confirmation_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFieldWidget(
                            myController: passwordConfirmationController,
                            type: TextInputType.visiblePassword,
                            obscure: true,
                            suffixIcon: Icons.remove_red_eye,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("birth_msg"),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormFieldWidget(
                            myController: birthController,
                            type: TextInputType.none,
                            suffixIcon: Icons.cake,
                            textAlignDir: TextAlign.left,
                            onTapFunc: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  builder: (context, child) => Theme(
                                        data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                          primary: primaryColor,
                                          // <-- SEE HERE
                                          onPrimary: Colors.white,
                                          // <-- SEE HERE
                                          onSurface: primaryColor,
                                        )),
                                        child: child!,
                                      ),
                                  context: context,
                                  initialDate: DateTime(2006),
                                  firstDate: DateTime(1924),
                                  lastDate: DateTime(2006));
                              if (pickedDate != null) {
                                  birthController.text =
                                      DateFormat("yyyy-MM-dd")
                                          .format(pickedDate)
                                          .toString();
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is RegisterLoadingState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return BtnPaddingWidget(
                                  horizontalPadding: 50,
                                  onPressedFun: () {
                                    if (validateForm()) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          AuthRegisterRequest(
                                              nameController.text,
                                              phoneController.text,
                                              emailController.text,
                                              passwordController.text,
                                              passwordConfirmationController
                                                  .text,
                                              birthController.text,
                                          addressController.text
                                          ));
                                    }
                                  },
                                  text: AppLocalizations.of(context)!
                                      .translate("signup_msg"),
                                  colorText: Colors.white,
                                  backColor: primaryColor);
                            },
                            listener: (context, state) {
                              if (state is RegisterFailureState) {
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

                              if (state is RegisterSuccessState) {
                                DioProvider.setTokenFromSharedPreferences();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()) , (route) => false,);
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
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
