import 'package:educationadmin/authentication/LoginScreen.dart';
import 'package:educationadmin/authentication/viewmodal/LoginViewModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/Flag.dart';
import 'package:educationadmin/widgets/CircularWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class RestForgotPassword extends StatefulWidget {
 RestForgotPassword({super.key,required this.phone});
  String phone;
  @override
  State<RestForgotPassword> createState() => _RestForgotPassword();
}

class _RestForgotPassword extends State<RestForgotPassword> {
  final AuthenticationViewModal _authenticationViewModel =
      Get.put(AuthenticationViewModal());

 final _formKey = GlobalKey<FormState>();
  
 
  late TextEditingController passwordController;
  late TextEditingController passwordController2;
  

  @override
  void initState() {
   

  
    passwordController = TextEditingController();
    passwordController2=TextEditingController();
   
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
                          height:25.h,
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          return Form(
                              key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Reset Password',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                               
                                const SizedBox(height: 20.0),
                          
                                
                                
                          
                               
                                
                                Container(
                                  width: constraints.maxWidth * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color:
                                        Colors.grey[200], // Grey background color
                                  ),
                                  child: TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter new password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder
                                          .none, // Hide the default border
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 20.0),
                                    ),
                                    validator: (value) {
                                      
                                      
    if (value == null || value.isEmpty ) {
      return 'Please enter valid password';
    }
    return null;
  },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                            Container(
                                  width: constraints.maxWidth * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color:
                                        Colors.grey[200], // Grey background color
                                  ),
                                  child: TextFormField(
                                    controller: passwordController2,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Re-enter new password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder
                                          .none, // Hide the default border
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 20.0),
                                    ),
                                    validator: (value) {
                                      
                                      
    if (value == null || value.isEmpty|| passwordController.text!=passwordController2.text) {
      return 'Passwords do not match';
    }
    return null;
  },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                          
                                ElevatedButton(
                                  onPressed: () async {
                                   FocusManager.instance.primaryFocus?.unfocus();
                                  bool validate=  _formKey.currentState!.validate();
                                  if(validate) {
                                  await  _authenticationViewModel.changePassword(
                                        phonenumber:widget.phone,password: passwordController.text,verificationType: VerificationType.ForgotPassword);
                                    Get.offAll(()=>const LoginScreen());
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
                                            :  Text(
                                                'Reset Password',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
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
