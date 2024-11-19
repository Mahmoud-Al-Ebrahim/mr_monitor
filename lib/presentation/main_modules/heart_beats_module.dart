import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../data/language_code_helper/app_localizations.dart';

class HeartBeatsModule extends StatefulWidget {
  const HeartBeatsModule({super.key, required this.connectionStatus});
  final ValueNotifier<int> connectionStatus ;

  @override
  State<HeartBeatsModule> createState() => _HeartBeatsModuleState();
}

class _HeartBeatsModuleState extends State<HeartBeatsModule> {
  //FlutterBlue flutterBlue = FlutterBlue.instance;
  // List<BluetoothDevice> devicesList = [];
  // BluetoothDevice? connectedDevice;
  BluetoothDiscoveryResult? discoveryResult ;
  BluetoothConnection? connection ;
  List<int> heartRateData = [];
  List<int> oxygenData = [];

  @override
  void initState() {
    super.initState();
  }

  bool isScanning = false;

  void scanForDevices() {

    FlutterBluetoothSerial.instance.startDiscovery().listen((event) {
      if(event.device.name=="HC-05") {
        discoveryResult = event;
        connectToDevice();
        FlutterBluetoothSerial.instance.cancelDiscovery();
      }
    },onDone: (){
      if(discoveryResult == null){
        widget.connectionStatus.value = 2;
      }
    });
  }
  Future<void> connectToDevice() async {
    connection = await  BluetoothConnection.toAddress(discoveryResult!.device.address);
      connection!.input!.listen((data) {
        print('Data incoming: ${data[0]}');
      }).onDone(() {
        print('Disconnected by remote request');
      });
    widget.connectionStatus.value = 1;
  }

  Future<void> disConnectDevice() async {
    connection?.cancel();
    connection?.finish();
    connection?.close();
    connection?.dispose();
    widget.connectionStatus.value = 0;
  }

  // void discoverServices(BluetoothDevice device) async {
  //   List<BluetoothService> services = await device.discoverServices();
  //   services.forEach((service) {
  //     service.characteristics.forEach((characteristic) {
  //       if (characteristic.properties.notify) {
  //         characteristic.setNotifyValue(true);
  //         characteristic.value.listen((value) {
  //           // هنا يمكنك معالجة البيانات المستلمة
  //           if (characteristic.uuid.toString() == "YOUR_HEART_RATE_CHARACTERISTIC_UUID") {
  //             heartRateData.add(value[1]); // افترض أن القيمة في الفهرس 1 هي نبض القلب
  //           } else if (characteristic.uuid.toString() == "YOUR_OXYGEN_CHARACTERISTIC_UUID") {
  //             oxygenData.add(value[1]); // افترض أن القيمة في الفهرس 1 هي الأكسجين
  //           }
  //           setState(() {});
  //         });
  //       }
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IconButton(
              //     onPressed: () => Navigator.of(context).pop(),
              //     icon: const Icon(
              //       Icons.arrow_back_ios_new_outlined,
              //       size: 30,
              //       color: primaryColor,
              //     )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image(image: AssetImage("assets/images/heart1.png")),
                    Image(image: AssetImage("assets/images/heart2.png")),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate("beats_msg"),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "76",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate("oxy_msg"),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "102",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<int>(
                  valueListenable: widget.connectionStatus,
                  builder: (context, status, _) {
                    return InkWell(
                      onTap: () {
                        if(status == 0 || status == 2) {
                          scanForDevices();
                        }else{
                          disConnectDevice();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 2), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              status == 0
                                  ? 'Connect'
                                  : status == 1
                                      ? 'Connected'
                                      : 'No Device Found',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: status == 0
                                      ? Colors.black
                                      : status == 1
                                          ? Colors.green[800]
                                          : Colors.red,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
