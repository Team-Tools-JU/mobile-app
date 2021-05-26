import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/app/models/implementation/android_service.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/implementation/navigation_controller.dart';
import 'package:mobile_app/src/app/models/implementation/settings_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/views/history/history_view.dart';
import 'package:mobile_app/src/app/views/navigation/navigation_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.I.registerSingleton<Bluetooth>(Bluetooth());
  GetIt.I.registerSingleton<AndroidService>(AndroidService());
  GetIt.I.registerSingleton<SettingsController>(SettingsController());
  GetIt.I.registerSingleton<NavigationController>(NavigationController());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HistoryView(),
    );
  }
}
