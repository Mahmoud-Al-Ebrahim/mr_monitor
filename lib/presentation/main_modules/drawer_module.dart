import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/presentation/drawer_pages/about_page.dart';
import 'package:mr_monitor3/presentation/pages/log_in_page.dart';
import 'package:mr_monitor3/presentation/pages/set_up_profile.dart';
import '../../data/language_code_helper/app_localizations.dart';
import '../drawer_pages/settings_page.dart';
import 'package:permission_handler/permission_handler.dart';
class DrawerModule extends StatelessWidget {

  void makePhoneCall(BuildContext context) async {
    await Permission.phone.request();
    print('tel:${BlocProvider.of<AuthBloc>(context).userData?.companionPhone}');
    final DirectCaller directCaller = DirectCaller();
    directCaller.makePhoneCall(BlocProvider.of<AuthBloc>(context).userData!.companionPhone!, simSlot: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(300),
        ),
        gradient: LinearGradient(
            begin: FractionalOffset.topRight,
            end: FractionalOffset.bottomLeft,
            colors: [Colors.grey.shade100, Colors.grey.shade900]),
        color: Colors.grey[200]?.withOpacity(.7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                width: 30,
                margin:
                    EdgeInsets.only(left: 0, top: 20, right: 30, bottom: 50),
                child: Icon(
                  Icons.close,
                  color: primaryColor,
                  size: 30,
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 35,
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SetUpProfilePage()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate("profile_msg"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 8,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SetUpProfilePage()));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.emergency_share,
                  color: primaryColor,
                  size: 35,
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      makePhoneCall(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate("sos_msg"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 8,
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.history,
                  color: primaryColor,
                  size: 35,
                ),
                Spacer(),
                InkWell(
                    onTap: () {},
                    child: Text(
                      AppLocalizations.of(context)!.translate("medical_msg"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 8,
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.settings,
                  color: primaryColor,
                  size: 35,
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingsPage()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate("settings_msg"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 8,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingsPage()));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.info_outline,
                  color: primaryColor,
                  size: 35,
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutAppPage()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate("about_msg"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 8,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutAppPage()));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.logout,
                  color: primaryColor,
                  size: 35,
                ),
                Spacer(),
                InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to Logout?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(LogoutEvent());

                                      Navigator.pushAndRemoveUntil(context , MaterialPageRoute(builder: (ctx)=> LoginPage()),(route) => false,);
                                    },
                                    child: const Text('YES')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('NO')),
                              ],
                            );
                          });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate("logout_msg"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(
                  flex: 8,
                ),
                InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to Logout?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(LogoutEvent());

                                      Navigator.pushAndRemoveUntil(context , MaterialPageRoute(builder: (ctx)=> LoginPage()),(route) => false,);
                                    },
                                    child: const Text('YES')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('NO')),
                              ],
                            );
                          });
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
