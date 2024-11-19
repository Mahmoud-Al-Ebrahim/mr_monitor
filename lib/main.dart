import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_monitor3/business_logic/appointment_bloc/appointment_bloc.dart';
import 'package:mr_monitor3/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mr_monitor3/business_logic/lang_cubit/locale_cubit.dart';
import 'package:mr_monitor3/presentation/main_modules/all_doctors_module.dart';
import 'package:mr_monitor3/presentation/pages/get_started_page.dart';
import 'package:mr_monitor3/services/notifications/awesome_notification.dart';
import 'package:mr_monitor3/services/notifications/local_notification_service.dart';
import 'package:mr_monitor3/services/notifications/notification_process.dart';
import 'package:mr_monitor3/util/get_it/get_it.dart';

import 'business_logic/doctor_cubit/doctor_cubit.dart';
import 'data/language_code_helper/app_localizations.dart';
import 'data/repository/doctor_repository.dart';
import 'data/web_services/doctor_web_service.dart';
import 'firebase_options.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//
//   LocalNotificationService()
//       .showNotificationWithPayload(message: message);
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // NotificationProcess().init();
  // NotificationProcess().fcmToken();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  try {
    await AwesomeNotification.init();
  }catch(e,st){
    print(e);
    print(st);
  }
  await getItInit();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  late DoctorRepository doctorRepository;
   MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    doctorRepository=DoctorRepository(DoctorWebServices());
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(create: (BuildContext context)=>DoctorCubit(doctorRepository)),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<AppointmentBloc>(
          create: (context) => AppointmentBloc(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          if (state is ChangeLocaleState) {
            return MaterialApp(
              navigatorKey: navigatorKey,
                locale: state.locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                  Locale('de')
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }

                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  textTheme: GoogleFonts.tajawalTextTheme(),
                ),
                home: GetStartedPage());
          }return SizedBox();
        },
      ),
    );
  }
}
