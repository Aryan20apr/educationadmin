// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:educationplatform/Modals/SignupResponseModal.dart';
// import 'package:educationplatform/Modals/SingnupModal.dart';
// import 'package:logger/logger.dart';

// class Network
// {
//   final String baseURL="https://aryan-nishant.hop.sh/";

//   final String signup="auth/signup";

//   final Dio _dio=Dio();
//  final Logger _logger=Logger();
//   Future<Response> signup({required SignupModal signupModal}) async 
//   {
//       Response response=await _dio.post(baseURL+signup,data: signupModal.toJson());
//       _logger.i("Signup sResponse:$response");

//       return response;

//   }
// }