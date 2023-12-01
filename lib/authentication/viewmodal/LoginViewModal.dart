
import 'package:educationadmin/Modals/LoginModal.dart';
import 'package:educationadmin/Modals/PasswordResetResponse.dart';
import 'package:educationadmin/Modals/PhoneVerificationModal.dart';
import 'package:educationadmin/Modals/SignupResponseModal.dart';
import 'package:educationadmin/Modals/SingnupModal.dart';
import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/authentication/LoginScreen.dart';
import 'package:educationadmin/authentication/OTPVerification.dart';
import 'package:educationadmin/authentication/ResetPassword.dart';
import 'package:educationadmin/authentication/SignupScreen.dart';

import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:educationadmin/utils/Flag.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../screens/common/MainScreen.dart';
import '../../utils/ColorConstants.dart';

class AuthenticationViewModal extends GetxController {

  RxBool isSiginingIn=false.obs;
  RxBool isSiginingUp=false.obs;
  RxBool isSendingOtp=false.obs;
  RxBool isChangingPassord=false.obs;
  RxBool iVerifyingOtp=false.obs;
  late final NetworkService networkService;
  late final AuthenticationManager _authManager;
final UserDetailsManager _userdetails=Get.put(UserDetailsManager());
 final NetworkService _networkService = Get.put(NetworkService());
  @override
  void onInit() {
    super.onInit();
    networkService = Get.put(NetworkService());
    _authManager = Get.put(AuthenticationManager());
  }

 Future<void> login({ String? email,required String password,required phone}) async {
    isSiginingIn.value=true;
    LoginModal loginModal=LoginModal( password:password, phone:phone);
    final SignupResponseModal response = await networkService
        .login(loginModal);

    if (response.data!=null) {
      /// Set isLogin to true
      _authManager.login(response.data!);

       UserModal userModal= await _networkService.getUserDetails(token: response.data!.token);
      _userdetails.initializeUserDetails(userModal: userModal);
        isSiginingIn.value=true;
      Get.off(()=>const MainWrapper());
      
    } else {
           isSiginingIn.value=true;
      /// Show user a dialog about the error response
      Get.defaultDialog(
        buttonColor: CustomColors.primaryColor,
        title: 'Login error',
        backgroundColor: CustomColors.secondaryColor,
          middleText: response.msg!,
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          confirm: ElevatedButton(onPressed: (){
            Get.back();

          },style: ElevatedButton.styleFrom(backgroundColor: CustomColors.primaryColor,foregroundColor:  CustomColors.secondaryColor), child:  const Text('Ok')),
      
          ); 
    }
  }

  Future<void> registerUser({required String email,required String password,required phone,required String name}) async {
    isSiginingUp.value=true;
    SignupModal signupModal=SignupModal(name:name, email:email, password:password, phone:phone);
    final SignupResponseModal response = await networkService
        .signUp(signupModal);

    if (response.data != null) {
      /// Set isLogin to true
      _authManager.login(response.data!/*,signupModal*/);
      
      UserModal userModal= await _networkService.getUserDetails(token: response.data!.token);
      _userdetails.initializeUserDetails(userModal: userModal);
       isSiginingUp.value=false;
      Get.off(()=>const MainWrapper());
    } else {
       isSiginingUp.value=false;
      /// Show user a dialog about the error response
      Get.defaultDialog(
        buttonColor: CustomColors.primaryColor,
          title: 'Register Error',
          middleText: response.msg!,
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> sendOtp({required String phone,required VerificationType verificationType}) async {
    isSendingOtp.value=true;
    PhoneModal phonemodal=PhoneModal(number:phone);
    final OTPModal? response = await networkService
        .sendOTP(phone:phonemodal);

    if (response != null) {
      /// Set isLogin to true
     
     await _authManager.saveOTP(response.data!.otp!);
      isSendingOtp.value=false;
       Logger().e("Sent number is $phone");
       if(verificationType==VerificationType.Signup || verificationType==VerificationType.ForgotPassword) {
         Get.to(()=>OtpVerification(phoneNumber: phone,verificationType: verificationType,),arguments: {"phoneNumber":phone});
       }
       else
       {
        
       }
      
     
    } else {
      isSendingOtp.value=false;
      /// Show user a dialog about the error response
      Get.defaultDialog(
          buttonColor: CustomColors.primaryColorDark,
          middleText: 'Registeration Error',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }
  Future<void> verifyOTP(String otp,String phoneNumber,{required VerificationType verificationType}) async {
      iVerifyingOtp.value=true;
      String? savedotp=await _authManager.getOTP();
      if(savedotp!=null)
      {
        if(otp==savedotp)
        {
            
          if(verificationType==VerificationType.Signup) {
            Get.off(()=>SignupScreen(phoneNumber:phoneNumber));
          }
          else if(verificationType==VerificationType.ForgotPassword)
          {
              Get.to(()=> RestForgotPassword(phone: phoneNumber));
          }
          else if(verificationType==VerificationType.ResetPassword)
          {

          }


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
      iVerifyingOtp.value=false;
  }

  Future<void> changePassword({  String? phonenumber,required String password,required VerificationType verificationType})async
  {
    isChangingPassord.value=true;
      
     
     if(verificationType==VerificationType.ForgotPassword)
     {PasswordResetResponse passwordResetResponse=await networkService.resetPassword(phone: phonenumber!, password: password);
      if(passwordResetResponse.data!=null&&passwordResetResponse.data!.status!)
      {
        Get.showSnackbar(const GetSnackBar(message:"Password changed successfully",duration: Duration(seconds: 3),));

      }
      else
      {
        Get.showSnackbar(const GetSnackBar(message:"Some error occured",duration: Duration(seconds: 3),));
      }
      }
      else if(verificationType==VerificationType.ResetPassword)
      {
        PasswordResetResponse passwordResetResponse=await networkService.resetPassword(phone: _userdetails.phone.value, password: password);
      if(passwordResetResponse.data!=null&&passwordResetResponse.data!.status!)
      {
        Get.showSnackbar(const GetSnackBar(message:"Password changed successfully",duration: Duration(seconds: 3),));

      }
      else 
      {
        Get.showSnackbar(const GetSnackBar(message:"Some error occured",duration: Duration(seconds: 3),));
      }
      

      }
        isChangingPassord.value=false;
      
  }
}