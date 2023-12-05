import 'dart:developer';

import 'package:talentsearchenglish/authentication/LoginScreen.dart';
import 'package:talentsearchenglish/screens/pages/Explore2.dart';
import 'package:talentsearchenglish/utils/ColorConstants.dart';

import 'package:talentsearchenglish/utils/Controllers/AuthenticationController.dart';
import 'package:talentsearchenglish/utils/Controllers/UserController.dart';
import 'package:talentsearchenglish/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../widgets/ProgressIndicatorWidget.dart';
import 'MainScreen.dart';

class FirstScreen extends StatelessWidget {
  final AuthenticationManager _authmanager =
      Get.put(AuthenticationManager(), permanent: true);
  final UserDetailsManager _userdetails =
      Get.put(UserDetailsManager(), permanent: true);

  final Logger logger = Logger();
  Future<void> initializeSettings() async {
    await _authmanager.checkLoginStatus();

    if (_authmanager.isLogged.value) {
      String? token = await _authmanager.getToken();
      logger.e("Token !=null ${token != null}");
      if (token != null) {
        _authmanager.isLogged.value = true;
        _userdetails.initializeFromStorage();
        //UserModal userModal= await _networkService.getUserDetails(token: token);
      }

      //Simulate other services for 3 seconds
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return const OnBoard();
          }
        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return const Scaffold(
        backgroundColor: CustomColors.secondaryColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ProgressIndicatorWidget(),
          ),
        ));
  }
}

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find<AuthenticationManager>();
    final UserDetailsManager _userdetails = Get.find<UserDetailsManager>();
    return Obx(() {
      log("Is Logged in and initialised ? ${_authManager.isLogged.value} ${_userdetails.isInitialised.value}");
      return _authManager.isLogged.value && _userdetails.isInitialised.value
          ? const MainWrapper()
          : const LoginScreen();
    });
  }
}
