
import 'package:educationadmin/Modals/LoginModal.dart';
import 'package:educationadmin/Modals/PhoneVerificationModal.dart';
import 'package:educationadmin/Modals/SignupResponseModal.dart';
import 'package:educationadmin/Modals/SingnupModal.dart';
import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/authentication/OTPVerification.dart';
import 'package:educationadmin/authentication/SignupScreen.dart';

import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../screens/common/MainScreen.dart';

class AuthenticationViewModal extends GetxController {

  final isLoading=false.obs;
  late final NetworkService _authenticationService;
  late final AuthenticationManager _authManager;
final UserDetailsManager _userdetails=Get.put(UserDetailsManager());
 final NetworkService _networkService = Get.put(NetworkService());
  @override
  void onInit() {
    super.onInit();
    _authenticationService = Get.put(NetworkService());
    _authManager = Get.put(AuthenticationManager());
  }

 Future<void> login({ String? email,required String password,required phone}) async {
    isLoading.value=true;
    LoginModal loginModal=LoginModal( password:password, phone:phone);
    final SignupResponseModal? response = await _authenticationService
        .login(loginModal);

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.data!);

       UserModal userModal= await _networkService.getUserDetails(token: response.data!.token);
      _userdetails.initializeUserDetails(userModal: userModal);
      isLoading.value=false;
      Get.off(()=> MainWrapper());
      
    } else {
       isLoading.value=false;
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Register Error',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> registerUser({required String email,required String password,required phone,required String name}) async {
    isLoading.value=true;
    SignupModal signupModal=SignupModal(name:name, email:email, password:password, phone:phone);
    final SignupResponseModal? response = await _authenticationService
        .signUp(signupModal);

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.data!/*,signupModal*/);
      
      UserModal userModal= await _networkService.getUserDetails(token: response.data!.token);
      _userdetails.initializeUserDetails(userModal: userModal);
      isLoading.value=false;
      Get.off(()=> MainWrapper());
    } else {
      isLoading.value=false;
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Register Error',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> sendOtp({required String phone}) async {
    isLoading.value=true;
    PhoneModal phonemodal=PhoneModal(number:phone);
    final OTPModal? response = await _authenticationService
        .sendOTP(phone:phonemodal);

    if (response != null) {
      /// Set isLogin to true
     
     await _authManager.saveOTP(response.data!.otp!);
       isLoading.value=false;
       Logger().e("Sent number is $phone");
      Get.to(()=>OtpVerification(phoneNumber: phone,),arguments: {"phoneNumber":phone});
      
     
    } else {
      isLoading.value=false;
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Register Error',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }
  Future<void> verifyOTP(String otp,String phoneNumber) async {
      String? savedotp=await _authManager.getOTP();
      if(savedotp!=null)
      {
        if(otp==savedotp)
        {
          Get.off(()=>SignupScreen(phoneNumber:phoneNumber));
        }
        else
        {
           Get.defaultDialog(
          middleText: 'OTP do not match',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
        }
      }
      else
      {
        Get.defaultDialog(
          middleText: 'Error obtaining otp',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
      }
  }
}