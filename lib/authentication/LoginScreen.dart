


import 'package:educationadmin/authentication/EmailVerification.dart';
import 'package:educationadmin/authentication/viewmodal/LoginViewModal.dart';
import 'package:educationadmin/widgets/CircularWidget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
class LoginScreen extends StatefulWidget {
 const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
late  TextEditingController phoneNumberController;
late TextEditingController passwordController;

  @override
  void initState() {
    phoneNumberController=TextEditingController();
    passwordController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModal authenticationViewModel = Get.put(AuthenticationViewModal());
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
                  
                        Container(
                          width: constraints.maxWidth*0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[200], // Grey background color
                        ),
                        child: TextField(
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Phone Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none, // Hide the default border
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: constraints.maxWidth*0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[200], // Grey background color
                        ),
                        child:  TextField(
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
                        authenticationViewModel.login(password: passwordController.text, phone: phoneNumberController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(constraints.maxWidth*0.8,constraints.maxHeight*0.2),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Obx(()=>authenticationViewModel.isLoading.value? const CircularProgressIndicator.adaptive(): const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),)
                      ),
                    ),
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[ Text(
                          'Don\'have an account?',
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(textStyle: TextStyle(fontSize:12.sp,fontWeight: FontWeight.bold)), onPressed: () { 
                            Get.to(()=>const PhoneVerification());
                           },
                          child:const Text('Sign up'),
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


