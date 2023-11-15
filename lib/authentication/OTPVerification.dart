

import 'package:educationadmin/authentication/viewmodal/LoginViewModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Flag.dart';
import 'package:educationadmin/utils/Themes.dart';
import 'package:educationadmin/widgets/CircularWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OtpVerification extends StatelessWidget {
   OtpVerification({super.key,required phoneNumber, required this.verificationType});
 String? phoneNumber;
 VerificationType verificationType;
   final AuthenticationViewModal _authenticationViewModel = Get.put(AuthenticationViewModal());
   TextEditingController? otpController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Stack(
            children: [
              const CirclesWidget()
              ,Column(
              children:[
                SizedBox(height: 30.h,
            ), 
                LayoutBuilder(builder: (context,constraints){
              
                return   Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              Text('Enter the otp sent to your registered phone number',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:50.0),
                                child: Pinput(
                                  controller: otpController,
                                  length: 6,
                                  keyboardType: TextInputType.number,
                                  defaultPinTheme: AppTheme.defaultPinTheme,
                                  focusedPinTheme: AppTheme.focusedPinTheme,
                                  submittedPinTheme: AppTheme.submittedPinTheme,
                                ),
                              ),
                               SizedBox(
                                height: 10.h,
                              ),
                               ElevatedButton(
                      onPressed: () async{
                        Logger().e("Phone Number: $phoneNumber");
                        _authenticationViewModel.verifyOTP(otpController!.text,Get.arguments["phoneNumber"],verificationType:verificationType);
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: CustomColors.primaryColorDark,
                        maximumSize: Size(constraints.maxWidth*0.8,constraints.maxHeight*0.2),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Obx(()=>_authenticationViewModel.isLoading.value? const ProgressIndicatorWidget():Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: CustomColors.primaryColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),)
                      ),
                    ),
                               Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[ Text(
                          'Didn\'t receive the code?',
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(textStyle: TextStyle(fontSize:12.sp,fontWeight: FontWeight.bold,color: CustomColors.primaryColorDark)), onPressed: () { 
                           
                           },
                          child:const Text('Resend OTP'),
                        ),
                        ]
                    ),
                
                              
                    ],
                  ),
                );
              }),]
            )],
          ),
          ),
          
          
          
        ),
      )
    );
  }
}