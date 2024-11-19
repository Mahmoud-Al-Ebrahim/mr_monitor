import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/main_modules/all_doctors_module.dart';
import 'package:mr_monitor3/presentation/main_modules/drawer_module.dart';
import 'package:mr_monitor3/presentation/main_modules/heart_beats_module.dart';
import 'package:mr_monitor3/presentation/main_modules/pharmacy_reminder_module.dart';

import '../../business_logic/auth_bloc/auth_bloc.dart';

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ValueNotifier<int> connectionStatus = ValueNotifier(0);
  int currentIndex = 2;
  List<Widget> screens = [
    AllDoctorsModule(),
    PharmacyReminderModule(),
    DrawerModule()
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(GetProfile());
    screens.insert(2, HeartBeatsModule(connectionStatus: connectionStatus));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        index: currentIndex,
        color: primaryColor,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(Icons.local_hospital, color: Colors.white,),
          Icon(Icons.medical_services, color: Colors.white,),
          Icon(Icons.heart_broken, color: Colors.white,),
          IconButton(
         onPressed:(){
           scaffoldKey.currentState
               ?.openEndDrawer();
         } , icon:Icon(Icons.account_balance, color: Colors.white)),
        ],),
    endDrawer: ClipRect(
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: DrawerModule(),
      ),
    ),
    );
  }
}