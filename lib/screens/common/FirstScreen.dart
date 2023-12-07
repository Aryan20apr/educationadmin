import 'dart:developer';

import 'package:talentsearchenglish/authentication/LoginScreen.dart';
import 'package:talentsearchenglish/screens/pages/Explore2.dart';
import 'package:talentsearchenglish/utils/ColorConstants.dart';

import 'package:talentsearchenglish/utils/Controllers/AuthenticationController.dart';
import 'package:talentsearchenglish/utils/Controllers/UserController.dart';
import 'package:talentsearchenglish/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:logger/logger.dart';

import '../../widgets/ProgressIndicatorWidget.dart';
import 'MainScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final AuthenticationManager _authmanager =
      Get.put(AuthenticationManager(), permanent: true);

  final UserDetailsManager _userdetails =
      Get.put(UserDetailsManager(), permanent: true);

  final Logger logger = Logger();

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;
  late Future<bool> isInitialised;

  @override
  void initState() {
    super.initState();
    isInitialised = initializeSettings();
  }

  Future<bool> initializeSettings() async {
    await _authmanager.checkLoginStatus();

    if (_authmanager.isLogged.value) {
      String? token = await _authmanager.getToken();
      logger.e("Token !=null ${token != null}");
      if (token != null) {
        _authmanager.isLogged.value = true;
        _userdetails.initializeFromStorage();
        //UserModal userModal= await _networkService.getUserDetails(token: token);
      }
    }
    await checkForUpdate();
    //Simulate other services for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      _updateInfo = info;
    }).catchError((e) {
      logger.e('In app update check failed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isInitialised,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            if (snapshot.hasData) {
              if (_updateInfo == null) {
                //Get.showSnackbar(const GetSnackBar(message: 'Could not check for update',duration: Duration(seconds: 3)));
                logger.e('In app update check failed');
                return const OnBoard();
              }
              if (_updateInfo!.updateAvailability ==
                  UpdateAvailability.updateAvailable) {
                InAppUpdate.performImmediateUpdate().catchError((e) {
                  logger.e('In app update failed');
                  return AppUpdateResult.inAppUpdateFailed;
                }).then((value) {
                  if (value == AppUpdateResult.inAppUpdateFailed) {
                    // Get.showSnackbar(const GetSnackBar(message: 'Could not complete update',duration: Duration(seconds: 3),));
                    logger.e('In app update completed');
                  }
                });
              }
            }
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
    AuthenticationManager authManager = Get.find<AuthenticationManager>();
    final UserDetailsManager userdetails = Get.find<UserDetailsManager>();
    return Obx(() {
      log("Is Logged in and initialised ? ${authManager.isLogged.value} ${userdetails.isInitialised.value}");
      return authManager.isLogged.value && userdetails.isInitialised.value
          ? const MainWrapper()
          : const LoginScreen();
    });
  }
}
