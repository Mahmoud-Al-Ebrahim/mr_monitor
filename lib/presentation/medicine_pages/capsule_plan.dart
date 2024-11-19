import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/business_logic/appointment_bloc/appointment_bloc.dart';
import 'package:mr_monitor3/core/colors.dart';
import 'package:mr_monitor3/data/models/appointments_model.dart';
import 'package:mr_monitor3/presentation/medicine_pages/reminder_page.dart';
import 'package:mr_monitor3/presentation/medicine_pages/single_capsule_widget.dart';
import 'package:mr_monitor3/services/notifications/awesome_notification.dart';
import 'package:mr_monitor3/util/show_snack_bar.dart';

import '../../data/language_code_helper/app_localizations.dart';

class Medication {
  String name;
  String time1;
  String? time2;
  String? time3;
  int count;

  Medication(
      {required this.name,
      required this.time1,
      this.time2,
      this.time3,
      required this.count});
}

class CapsulePlanPage extends StatefulWidget {
  @override
  State<CapsulePlanPage> createState() => _CapsulePlanPageState();
}

class _CapsulePlanPageState extends State<CapsulePlanPage> {
  TextEditingController medicationNamePicker = TextEditingController();
  TextEditingController time1Picker = TextEditingController();
  TextEditingController time2Picker = TextEditingController();
  TextEditingController time3Picker = TextEditingController();
  TextEditingController dosesNum = TextEditingController();

  void _addMedication() {
    String medicationName = medicationNamePicker.text;
    String medicationTime1 = time1Picker.text;
    String? medicationTime2 = time2Picker.text;
    String? medicationTime3 = time3Picker.text;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Medication',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: medicationNamePicker,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    labelText: 'Medication Name:',
                    labelStyle: TextStyle(color: primaryColor)),
                onChanged: (value) {
                  medicationName = value;
                },
              ),
              TextField(
                controller: dosesNum,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    labelText: 'days count:',
                    labelStyle: TextStyle(color: primaryColor)),
                onChanged: (value) {},
              ),
              TextField(
                controller: time1Picker,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    labelText: 'Time (e.g., 08:00 AM)',
                    labelStyle: TextStyle(color: primaryColor)),
                onTap: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                        primary: primaryColor,
                        onSurface: primaryColor,
                      )),
                      child: child!,
                    ),
                  );
                  if (time != null) {
                    print(time.format(context));
                    time1Picker.text = medicationTime1 = time.format(context);
                  }
                },
              ),
              TextField(
                controller: time2Picker,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    labelText: 'Time2(option)',
                    labelStyle: TextStyle(color: primaryColor)),
                onTap: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                        primary: primaryColor,
                        onSurface: primaryColor,
                      )),
                      child: child!,
                    ),
                  );
                  if (time != null) {
                    time2Picker.text = medicationTime2 = time.format(context);
                  }
                },
              ),
              TextField(
                controller: time3Picker,
                cursorColor: primaryColor,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    labelText: 'Time3(option)',
                    labelStyle: TextStyle(color: primaryColor)),
                onTap: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                        primary: primaryColor,
                        onSurface: primaryColor,
                      )),
                      child: child!,
                    ),
                  );
                  if (time != null) {
                    time3Picker.text = medicationTime3 = time.format(context);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Add',
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () async{
                if (medicationNamePicker.text.isEmpty) {
                  showMessage(context, 'medicine name must not be empty');
                  return;
                }
                if (medicationNamePicker.text.length < 3) {
                  showMessage(
                      context, 'medicine name must be at least 3 characters');
                  return;
                }
                if (dosesNum.text.isEmpty) {
                  showMessage(context, 'Please add doses Num');
                  return;
                }
                if (int.tryParse(dosesNum.text) == null) {
                  showMessage(context, 'Please provide a valid doses num');
                  return;
                }
                if (int.parse(dosesNum.text) < 1) {
                  showMessage(context, 'doses num must be at least 1');
                  return;
                }
                if (time1Picker.text.isEmpty) {
                  showMessage(context,
                      'You must add at least one date to take medicine');
                  return;
                }
                if (time2Picker.text.isNotEmpty &&
                    (time2Picker.text == time1Picker.text)) {
                  showMessage(context, 'You must choose different times');
                  return;
                }
                if (time3Picker.text.isNotEmpty &&
                    (time1Picker.text == time3Picker.text)) {
                  showMessage(context, 'You must choose different times');
                  return;
                }
                if (time3Picker.text.isNotEmpty &&
                    time2Picker.text.isNotEmpty &&
                    (time2Picker.text == time3Picker.text)) {
                  showMessage(context, 'You must choose different times');
                  return;
                }
                BlocProvider.of<AppointmentBloc>(context).add(
                    StoreAppointmentEvent(
                        medicineName: medicationName,
                        dosesNum: dosesNum.text,
                        time1: medicationTime1,
                        time2: medicationTime2,
                        time3: medicationTime3));

                dosesNum.clear();
                medicationNamePicker.clear();
                time1Picker.clear();
                time2Picker.clear();
                time3Picker.clear();
                Navigator.of(context).pop();
                // }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<AppointmentBloc>(context).add(GetAppointmentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AppointmentBloc, AppointmentState>(
            listener: (ctx, state) {
              if (state is GetAppointmentFailureState) {
                showMessage(context, state.message);
              }
              if (state is StoreAppointmentFailureState) {
                showMessage(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is GetAppointmentLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is StoreAppointmentLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, List<AppointmentModel>> medications =
                  BlocProvider.of<AppointmentBloc>(context).medications;
              Map<String, int> countOfPillsPerMedicine =
                  BlocProvider.of<AppointmentBloc>(context)
                      .countOfPillsPerMedicine;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate("today_plan_msg"),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3, right: 2),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                _addMedication();
                              },
                              icon: Icon(
                                Icons.add,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: medications.length,
                          itemBuilder: (context, outerIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  medications.keys
                                      .elementAt(outerIndex)
                                      .substring(0, 5),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: ValueKey(
                                            '${DateTime.now()} $index'),
                                        direction: DismissDirection.endToStart,
                                        confirmDismiss: (direction) async {
                                          bool dismiss = false;
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Are you sure you want to delete the medicine And its appointment?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            dismiss = true;
                                                            BlocProvider.of<
                                                                        AppointmentBloc>(
                                                                    context)
                                                                .add(DeleteAppointmentEvent(
                                                                    medicineId: medications[medications
                                                                            .keys
                                                                            .elementAt(outerIndex)]![index]
                                                                        .id
                                                                        .toString()));
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'YES')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text('NO')),
                                                    ],
                                                  );
                                                });
                                          }
                                          return dismiss;
                                        },
                                        background: Container(
                                          color: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          alignment: Alignment.centerLeft,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: SingleCapsuleWidget(
                                            name: medications[medications.keys
                                                    .elementAt(
                                                        outerIndex)]![index]
                                                .name!,
                                            countPerDay: countOfPillsPerMedicine[
                                                    medications[medications.keys
                                                                .elementAt(
                                                                    outerIndex)]![
                                                            index]
                                                        .name!]
                                                .toString()),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: 15,
                                      );
                                    },
                                    itemCount: medications[medications.keys
                                                .elementAt(outerIndex)]
                                            ?.length ??
                                        0),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
