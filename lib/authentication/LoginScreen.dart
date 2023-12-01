


import 'package:educationadmin/authentication/PhoneVerification.dart';
import 'package:educationadmin/authentication/ForgotPasswordPhone.dart';
import 'package:educationadmin/authentication/viewmodal/LoginViewModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/widgets/CircularWidget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../widgets/ProgressIndicatorWidget.dart';
class LoginScreen extends StatefulWidget {
 const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
late  TextEditingController phoneNumberController;
late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
final AuthenticationViewModal authenticationViewModel = Get.put(AuthenticationViewModal());
  @override
  void initState() {
    super.initState();
    phoneNumberController=TextEditingController();
    passwordController=TextEditingController();
    authenticationViewModel.isSiginingIn.value=false;
    
  }
 @override
 void dispose()
 {
  authenticationViewModel.isSiginingIn.value=false;
  super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                SizedBox(height: 15.h,
            ), 
                LayoutBuilder(builder: (context,constraints){
              
                return  Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              
                     Text('Welcome Back',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                  
                  
                      SvgPicture.asset('assets/login.svg',fit: BoxFit.scaleDown,height:40.h,),
                  
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                width: constraints.maxWidth*0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.grey[200], // Grey background color
                              ),
                              child: TextFormField(
                                controller: phoneNumberController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your Phone Number',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none, // Hide the default border
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                                validator: (value) {
                                  if(value == null||value.length!=10)
                                  {
                                      return 'Not a valid phone number';
                                  }
                                },
                              ),
                                              ),
                                              const SizedBox(height: 20.0),
                                              Container(
                              width: constraints.maxWidth*0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.grey[200], // Grey background color
                              ),
                              child:  TextFormField(
                                validator: (value) {
                                  if(value==null||value.isEmpty)
                                  {
                                      return 'Password cannot be empty';
                                  }
                                },
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none, // Hide the default border
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                              ),
                                              ),
                                              const SizedBox(height: 20.0),
                                              ElevatedButton(
                                              onPressed: () {
                                                if(_formKey.currentState!
                                                .validate()) {
                                                  authenticationViewModel.login(password: passwordController.text, phone: phoneNumberController.text);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                backgroundColor:  Theme.of(context).primaryColor,
                                foregroundColor:  Theme.of(context).primaryColorDark,
                              maximumSize: Size(constraints.maxWidth*0.8,constraints.maxHeight*0.2),
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                                              ),
                                              child: Container(
                              
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Obx(()=>authenticationViewModel.isSiginingIn.value?  const ProgressIndicatorWidget():  Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  
                                ),
                              ),)
                                              ),
                                            ),
                            ],
                          ),
                        ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[ Text(
                          'Forgot Passowrd?',
                          style: TextStyle(fontSize:10.sp,fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(foregroundColor:  Theme.of(context).primaryColorDark,textStyle: TextStyle(color:  Theme.of(context).primaryColorDark,fontSize:10.sp,fontWeight: FontWeight.bold)), onPressed: () { 
                            Get.to(()=>const ForgotPasswordPhoneVerification());
                           },
                          child:const Text('Reset',),
                        ),
                        ]
                    ),
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[ Text(
                          'Don\'have an account?',
                          style: TextStyle(fontSize:10.sp,fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(foregroundColor:  Theme.of(context).primaryColorDark,textStyle: TextStyle(color:  Theme.of(context).primaryColorDark,fontSize:10.sp,fontWeight: FontWeight.bold)), onPressed: () { 
                            Get.to(()=>const PhoneVerification());
                           },
                          child:const Text('Sign up',),
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


