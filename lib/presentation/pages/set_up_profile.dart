import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mr_monitor3/data/models/user_model.dart';
import 'package:mr_monitor3/util/show_snack_bar.dart';
import '../../business_logic/auth_bloc/auth_bloc.dart';
import '../../components/btn_widget.dart';
import '../../components/text_form_field_widget.dart';
import '../../core/colors.dart';
import '../../data/language_code_helper/app_localizations.dart';

class SetUpProfilePage extends StatefulWidget {
  @override
  State<SetUpProfilePage> createState() => _SetUpProfilePageState();
}

class _SetUpProfilePageState extends State<SetUpProfilePage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController birthController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  bool isMale = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context , state){
              if(state is GetProfileFailureState){
                showMessage(context, state.message);
              }
              if(state is UpdateProfileFailureState){
                showMessage(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthInitialState || state is GetProfileLoadingState || state is UpdateProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              User? user = BlocProvider.of<AuthBloc>(context).userData;
              if(user == null){
                return Center(
                  child: BtnPaddingWidget(
                      horizontalPadding: 50,
                      onPressedFun: () {
                          BlocProvider.of<AuthBloc>(context).add(GetProfile());
                      },
                      text: 'Try Again',
                      colorText: Colors.white,
                      backColor: primaryColor),
                );
              }
              if (nameController.text.isEmpty) {
                nameController.text = user.name!;
                phoneController.text = user.companionPhone!;
                emailController.text = user.email!;
                birthController.text = DateFormat("yyyy-MM-dd")
                    .format(user.birthday!)
                    .toString();
                addressController.text = user.address!;
              }
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 30,
                                color: primaryColor,
                              )),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Set Up Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 30),
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Center(
                      //   child: Stack(
                      //     children:[
                      //       ClipOval(
                      //         child: Image(
                      //             width: 160,
                      //             height: 160,
                      //             fit: BoxFit.cover,
                      //             image:AssetImage("assets/images/tawfik.jpg")
                      //         ),
                      //       ),
                      //       Positioned(
                      //         bottom: 0,
                      //           right: 10,
                      //           child:CircleAvatar(
                      //             backgroundColor: primaryColor,
                      //             radius: 17,
                      //             child: IconButton(
                      //               onPressed: (){},
                      //               icon: Icon(
                      //                 Icons.camera_alt_rounded,
                      //                 color: Colors.white,
                      //                 size: 20,
                      //               ),
                      //             ),
                      //           ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Personal information:",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Full Name",
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
                          "Contact Number",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormFieldWidget(
                        myController: phoneController,
                        type: TextInputType.phone,
                        suffixIcon: Icons.phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "E-Mail",
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
                          'Address',
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
                          AppLocalizations.of(context)!.translate("birth_msg"),
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
                                        colorScheme: const ColorScheme.light(
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
                            birthController.text = DateFormat("yyyy-MM-dd")
                                .format(pickedDate)
                                .toString();
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BtnPaddingWidget(
                          horizontalPadding: 50,
                          onPressedFun: () {
                            if (validateForm()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  UpdateProfileRequest(
                                      nameController.text,
                                      phoneController.text,
                                      emailController.text,
                                      birthController.text,
                                      addressController.text));
                            }
                          },
                          text: "Edit",
                          colorText: Colors.white,
                          backColor: primaryColor),
                    ],
                  ),
                ),
              );
            },
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
