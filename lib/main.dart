import 'package:device_preview/device_preview.dart';

import 'package:educationadmin/utils/Themes.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';    
import 'package:get/get.dart';


import 'package:sizer/sizer.dart';

import 'screens/common/FirstScreen.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
    
  runApp(  DevicePreview(
    enabled: kReleaseMode,                                          

     
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return Sizer(
      builder: (context, orientation, deviceType) {
        
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home:   FirstScreen()
    );
  });
}
}

