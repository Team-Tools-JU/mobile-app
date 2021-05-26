import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/app/models/implementation/android_service.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/implementation/navigation_controller.dart';
import 'package:mobile_app/src/app/models/implementation/settings_controller.dart';
import 'package:mobile_app/src/app/views/start/start_view.dart';

import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/views/navigation/navigation_view.dart';
import 'package:mobile_app/src/app/views/settings/settings_view.dart';
import 'package:mobile_app/src/app/views/settings/settings_view_model.dart';
import 'package:mobile_app/src/app/views/start/start_view.dart';
import 'package:mobile_app/src/app/views/steering/steering_view.dart';
import 'package:mobile_app/src/app/views/history/history_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<Bluetooth>(Bluetooth());
  GetIt.I.registerSingleton<AndroidService>(AndroidService());
  GetIt.I.registerSingleton<SettingsController>(SettingsController());
  GetIt.I.registerSingleton<NavigationController>(NavigationController());

//import 'package:firebase_core/firebase_core.dart';

//Future<void> main() async {
  // Using Future Builder for async function

  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp()

  runApp(App());
}

class App extends StatelessWidget {
 // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavigationView(),
    );
  }
}
 //   return MaterialApp(
   //     title: 'Flutter Demo',
   //     theme: ThemeData(

    //      primarySwatch: Colors.blue,

     //     visualDensity: VisualDensity.adaptivePlatformDensity,
     //   ),
     //   home: FutureBuilder(
      //    future: _fbApp,
      //    builder: (context, snapshot) {
      //      if (snapshot.hasError) {
      //        print('Error found!, ${snapshot.error.toString()}');
      //        return Text('Something went wrong!');
       //     } else if (snapshot.hasData) {
       //       return StartView();
       //     } else {
        //      return Center(
       //         child: CircularProgressIndicator(),
       //       );
      //      }
    //      },
    //    ));


