import 'dart:async';



import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/Modals/FileResourcesModal.dart';
import 'package:educationadmin/Modals/LoginModal.dart';
import 'package:educationadmin/Modals/PhoneVerificationModal.dart';
import 'package:educationadmin/Modals/SignupResponseModal.dart';
import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/utils/status.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:logger/logger.dart';

import '../../Modals/SingnupModal.dart';


/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class NetworkService extends GetConnect {
  final String baseURL="https://backend-for-unidev.hop.sh/";

  final String signup="auth/signup";
  final String signin="auth/signin";
  final String sendotp="auth/getOtp";
  final String user="auth/getConsumer";
  final String channels="channels/all";
  final String channelfiles="resources/channel/files/";
  final String channelvideos="resources/channel/videos/";


  final String userchannels="channels/..";

  Future<SignupResponseModal?> signUp(SignupModal model) async {
    Response<Map<String,dynamic>> response = await post('$baseURL$signup', model.toJson());
    Logger().e(response.body.toString());
    if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created) {
      return SignupResponseModal.fromJson(response.body!);
    } else {


TODO: "Handle signup error ";
      return null; 
      //return SignupErrorModal.fromJson(response.body!);
    }
  }

 Future<SignupResponseModal?> login(LoginModal model) async {
    Response<Map<String,dynamic>> response = await post('$baseURL$signin', model.toJson());
    Logger().e(response.body.toString());
    if(response.body!=null)
    {
    if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created) {
      return SignupResponseModal.fromJson(response.body!);
    }
    }
     else {


TODO: "Handle signup error ";
      return null; 
      //return SignupErrorModal.fromJson(response.body!);
    }
  }

Future<OTPModal?> sendOTP({required PhoneModal phone}) async {
    Response<Map<String,dynamic>> response = await post('$baseURL$sendotp', phone.toJson());
    Logger().e(response.body);
    if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created) {
      
      return OTPModal.fromJson(response.body!);
    } else {


TODO: "Handle OTP error ";
      return OTPModal.fromJson(response.body!);
      //return SignupErrorModal.fromJson(response.body!);
    }
  }

  Future<UserModal> getUserDetails({String? token}) async {
    try {
  Response<Map<String,dynamic>> response = await get('$baseURL$user',headers: {"Authorization":"Bearer $token"});
  if(response.body==null) {
    throw Exception("Could not obtain user data");
  }
  
  Logger().e("Response of userDetails api ${response.body}");
    if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created) {
      
      return UserModal.fromJson(response.body!);
    } else {


TODO: "Handle error";
      return UserModal.fromJson(response.body!);
      //return SignupErrorModal.fromJson(response.body!);
    }
} on TimeoutException catch (_) {
  return UserModal();
}
on Exception catch (_) {
  return UserModal();
}
    
  }



Future<ChannelListModal> getAllChannelList({String? token}) async
{
  Response<Map<String,dynamic>> response = await get('$baseURL$channels',headers: {"Authorization":"Bearer $token"});
    Logger().e(response.body);
   return ChannelListModal.fromJson(response.body!);
  }
Future<ChannelListModal> getUserChannelList({String? token,required int userid}) async
{
  Response<Map<String,dynamic>> response = await get('$baseURL$channels',headers: {"Authorization":"Bearer $token"});
    Logger().e(response.body);
   return ChannelListModal.fromJson(response.body!);
  }

Future<FileResourcesData> getChannelFiles({String? token, required int channelId}) async
{
Response<Map<String,dynamic>> response = await get('$baseURL$channelfiles$channelId',headers: {"Authorization":"Bearer $token"});
    Logger().e(response.body);
   return FileResourcesData.fromJson(response.body!);
}

Future<VideoResourcesData> getChannelVideo({String? token, required int channelId}) async
{
Response<Map<String,dynamic>> response = await get('$baseURL$channelvideos$channelId',headers: {"Authorization":"Bearer $token"});
    Logger().e(response.body);
   return VideoResourcesData.fromJson(response.body!);
}


}
 
