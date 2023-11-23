import 'package:educationadmin/authentication/LoginScreen.dart';
import 'package:educationadmin/authentication/viewmodal/LoginViewModal.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/widgets/CircularWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
class SignupScreen extends StatefulWidget {
  SignupScreen({super.key,required this.phoneNumber});
  String? phoneNumber;
  @override
  State<SignupScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SignupScreen> {

final AuthenticationViewModal _authenticationViewModel = Get.put(AuthenticationViewModal());

late  TextEditingController emailController;
late TextEditingController passwordController;
late  TextEditingController fullnameController;
late TextEditingController phoneNumberController;
late  TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController=TextEditingController();
    passwordController=TextEditingController();
    
    fullnameController=TextEditingController();
    phoneNumberController=TextEditingController(text: widget.phoneNumber);
    confirmPasswordController=TextEditingController();
    super.initState();
  }

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SizedBox(height: 15.h,
              ), 
                  LayoutBuilder(builder: (context,constraints){
                
                  return  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                                  
                        Text('Welcome Onboard!',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                         Text('Get started with',style: TextStyle(fontSize: 12.sp),),
                           const SizedBox(height: 20.0),
                                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed: () {  },
                            icon: SvgPicture.asset('assets/google.svg',fit: BoxFit.scaleDown)),
                            IconButton(onPressed: () {  },
                            icon: SvgPicture.asset('assets/facebook.svg',fit: BoxFit.scaleDown)),
                          ],
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Divider(
                          thickness: 1.h,
                          // Equal-Length Line Below
                          color: Colors.black,
                         
                        ),
                        Text(
                          'or create new account',
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w300),
                        ),
                        Divider(
                          thickness: 1.h,
                          // Equal-Length Line Below
                          color: Colors.black,
                         
                        ),
                        
                      ],
                    ),
                                   const SizedBox(height: 20.0),
                          Container(
                            width: constraints.maxWidth*0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey[200], // Grey background color
                          ),
                          child:  TextFormField(
                            controller: fullnameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Enter your full name',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Hide the default border
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            validator: (value) {
                                    if(value == null||value.isEmpty)
                                    {
                                        return 'Name cannot be empty';
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
                  
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Hide the default border
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            validator: (value) {
                              if(value == null||value.isEmpty)
                                    {
                                      final bool emailValid = 
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                        if(emailValid) {
                          return null;
                        }
                        else {
                          return 'Enter a valid email id';
                        }
                        
                            }
                            else {
                                return 'Email id cannot be empty';
                              }
                            }
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
                            enabled: false,
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Hide the default border
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          
                              validator: (value) {
                                    if(value == null||value.length!=10)
                                    {
                                        return 'Not a valid phone number';
                                    }
                                  else {
                                      return null;
                                    }
                                  
                            }
                  
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
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Hide the default border
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            validator: (value) {
                                    if(value == null||value.isEmpty)
                                    {
                                        return 'Password cannot be empty';
                                    }
                                  else {
                                      return null;
                                    }
                                  
                            }
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
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              hintText: 'Confirm password',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Hide the default border
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            validator: (value) {
                                    if(value == null||value.isEmpty||value!=passwordController.text)
                                    {
                                        return 'Both passwords do not match';
                                    }
                                  else {
                                      return null;
                                    }
                                  
                            }
                          ),
                        ),
                       
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate()) {
                            _authenticationViewModel.registerUser(email: emailController.text, password: passwordController.text, phone: phoneNumberController.text, name: fullnameController.text);
                          }
                          //Get.to(()=>const OtpVerification());
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
                          child: Obx(()=>_authenticationViewModel.isLoading.value? const ProgressIndicatorWidget(): const Text(
                            'Sign Up',
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
                            'Already have an account?',
                            style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w300),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(textStyle: TextStyle(fontSize:12.sp,fontWeight: FontWeight.bold)), onPressed: () { 
                              Get.to(()=>const LoginScreen());
                             },
                            child:const Text('Sign in'),
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


