
import 'package:educationadmin/authentication/viewmodal/LoginViewModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/Flag.dart';
import 'package:educationadmin/widgets/CircularWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class ForgotPasswordPhoneVerification extends StatefulWidget {
  const ForgotPasswordPhoneVerification({super.key});

  @override
  State<ForgotPasswordPhoneVerification> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ForgotPasswordPhoneVerification> {
  final AuthenticationViewModal _authenticationViewModel =
      Get.put(AuthenticationViewModal());

 final _formKey = GlobalKey<FormState>();
  
 
  late TextEditingController phoneNumberController;
  

  @override
  void initState() {
   

  
    phoneNumberController = TextEditingController();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  const CirclesWidget(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          return Form(
                              key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                               
                                const SizedBox(height: 20.0),
                          
                                Text(
                                      'Enter your registered phone number for verification:',
                                      textAlign: TextAlign.center,style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w300),
                                    ),
                                const SizedBox(height: 20.0),
                          
                               
                                const SizedBox(height: 20.0),
                                Container(
                                  width: constraints.maxWidth * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color:
                                        Colors.grey[200], // Grey background color
                                  ),
                                  child: TextFormField(
                                    controller: phoneNumberController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your 10 digit phone number',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder
                                          .none, // Hide the default border
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 20.0),
                                    ),
                                    validator: (value) {
                                       String pattern=r'^[0-9]{10}$';
                                       RegExp regExp=RegExp(pattern);
    if (value == null || value.isEmpty|| value.length!=10|| !regExp.hasMatch(value)) {
      return 'Please enter valid phone number';
    }
    return null;
  },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                          
                                ElevatedButton(
                                  onPressed: () async {
                                   
                                  bool validate=  _formKey.currentState!.validate();
                                  if(validate) {
                                    _authenticationViewModel.sendOtp(
                                        phone: phoneNumberController.text,verificationType: VerificationType.ForgotPassword);
                                  }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor:
                                        Theme.of(context).primaryColorDark,
                                    maximumSize: Size(constraints.maxWidth * 0.8,
                                        constraints.maxHeight * 0.2),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Obx(
                                        () => _authenticationViewModel
                                                .isLoading.value
                                            ? const ProgressIndicatorWidget()
                                            : const Text(
                                                'Get OTP',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      )),
                                ),
                                
                              ],
                            ),
                          );
                        }),
                      ])
                ],
              ),
            ),
          ),
        ));
  }
}
