import 'dart:async';
import 'dart:io';
import 'dart:math';


import 'package:educationadmin/Modals/ChannelCreationResponse.dart';
import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/Modals/FileResourcesModal.dart';
import 'package:educationadmin/Modals/FileUploadResponseModal.dart';
import 'package:educationadmin/Modals/LoginModal.dart';
import 'package:educationadmin/Modals/PhoneVerificationModal.dart';
import 'package:educationadmin/Modals/SignupResponseModal.dart';
import 'package:educationadmin/Modals/SubsciberModal.dart';
import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/Modals/VideoRequestModal.dart';
import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/Modals/VideoUploadResponse.dart';
import 'package:educationadmin/utils/status.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' as dio;
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
  final String creatorChannels="channels/creator/channels";
  
  final String createchannel="channels/create";
  final String userchannels="channels/..";
  final String editchannel="channels/edit";
  final String deletechannel="channels/delete/";
  final String addconsumerfromcreator="subscription/subscribe/creator";
  final String addresource="resources/create";
  final String channelsubscribers="analytics/channel/myConsumers/";
  final String uploadpdf="resources/upload/pdf";

  final Logger logger=Logger();
  Future<SignupResponseModal?> signUp(SignupModal model) async {
    Response<Map<String,dynamic>> response = await post('$baseURL$signup', model.toJson());
    logger.e(response.body.toString());
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
    logger.e(response.body.toString());
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
    logger.e(response.body);
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
  
  logger.e("Response of userDetails api ${response.body}");
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
    logger.e(response.body);
   return ChannelListModal.fromJson(response.body!);
  }
Future<ChannelListModal> getCreatorList({String? token}) async
{
  try {
  Response<Map<String,dynamic>> response = await get('$baseURL$creatorChannels',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
   return ChannelListModal.fromJson(response.body!);
} on Exception catch (e) {
  e.printError();
  return ChannelListModal();
}
  }
Future<ChannelListModal> getUserChannelList({String? token,required int userid}) async
{
  Response<Map<String,dynamic>> response = await get('$baseURL$channels',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
   return ChannelListModal.fromJson(response.body!);
  }

Future<FileResourcesData> getChannelFiles({String? token, required int channelId}) async
{
Response<Map<String,dynamic>> response = await get('$baseURL$channelfiles$channelId',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
   return FileResourcesData.fromJson(response.body!);
}

Future<VideoResourcesData> getChannelVideo({String? token, required int channelId}) async
{
Response<Map<String,dynamic>> response = await get('$baseURL$channelvideos$channelId',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
   return VideoResourcesData.fromJson(response.body!);
}


Future<CreateChannelResponseModal> createChannel({required String? token, required XFile file,required bool isCompletelyPaid, required String name,required int price })async
{
   var formData = dio.FormData.fromMap({
  
  'file': await dio.MultipartFile.fromFile(file.path,filename: file.name),
  
    'price': price,
    'isCompletelyPaid': isCompletelyPaid,
    'name': name,
});


  //   FormData formData = FormData({
  //   'file':  MultipartFile(file,filename: name),
  //   'price': price,
  //   'isCompletelyPaid': '"$isCompletelyPaid"',
  //   'name': name,
  // });

   try {
    //Response<Map<String,dynamic>> response=await post('$baseURL$createchannel', formData,contentType:"multipart/form-data",headers: {"Authorization":"Bearer $token"} );
    dio.Response<Map<String,dynamic>> response = await dio.Dio().post('$baseURL$createchannel', data: formData,options: dio.Options(contentType: "multipart/form-data",headers:{"Authorization":"Bearer $token"}));
    print(response.data);
    if (response.statusCode == 200||response.statusCode==201) {
      print('Success: ${response.data}');
      return CreateChannelResponseModal.fromJson(response.data!);
    } else {
      return CreateChannelResponseModal();
    }
  } catch (e) {
    print('Error: $e');
   
  }
   return CreateChannelResponseModal();
  }
Future<CreateChannelResponseModal> editChannel({required String? token, XFile? file, required String name,required int channelid})async
{
   var formData;
   if(file!=null)
   { 
   formData = dio.FormData.fromMap({
  
  'file': await dio.MultipartFile.fromFile(file.path,filename: file.name),
    'name': name,
});}
else
{
  formData = dio.FormData.fromMap({
  
  
    'name': name,
});}


  //   FormData formData = FormData({
  //   'file':  MultipartFile(file,filename: name),
  //   'price': price,
  //   'isCompletelyPaid': '"$isCompletelyPaid"',
  //   'name': name,
  // });

   try {
    //Response<Map<String,dynamic>> response=await post('$baseURL$createchannel', formData,contentType:"multipart/form-data",headers: {"Authorization":"Bearer $token"} );
    dio.Response<Map<String,dynamic>> response = await dio.Dio().put('$baseURL$editchannel/$channelid', data: formData,options: dio.Options(contentType: "multipart/form-data",headers:{"Authorization":"Bearer $token"}));
    print(response.data);
    if (response.statusCode == 200||response.statusCode==201) {
      print('Success: ${response.data}');
      return CreateChannelResponseModal.fromJson(response.data!);
    } else {
      return CreateChannelResponseModal();
    }
  } catch (e) {
    print('Error: $e');
   
  }
   return CreateChannelResponseModal();
  }

  Future<bool> deleteChannel({required String token,required int channelId})async
  {
      Response<Map<String,dynamic>> response=await delete("$baseURL$deletechannel$channelId",headers: {"Authorization":"Bearer $token"});

      if(response.statusCode==200 ||response.statusCode==201)
      {
        return true;

      }
      else
      {
        return false;
      }
  }
  Future<GeneralResponse> subscribeByCreator({required String token,required int channelId,required int consumerId})async
  {
     try {
  Response<Map<String,dynamic>> response=await post("$baseURL$addconsumerfromcreator/$channelId/$consumerId",{},headers: {"Authorization":"Bearer $token"});
   
   if(response.statusCode==200 ||response.statusCode==201)
   {
     return GeneralResponse.fromJson(response.body!);
  
   }
  
} on Exception catch (e) {
   return GeneralResponse(msg: "Could not subscibe",status: false);
}
return   GeneralResponse(msg: "Could not subscibe",status: false);
  }
  

  Future<VideoUploadResponseModal> uploadVideo({required String token,required VideoRequestModal videoRequestModal})async
{
  try{
    Response<Map<String,dynamic>> response=await post('$baseURL$addresource',videoRequestModal.toJson(),headers: {"Authorization":"Bearer $token"});
      logger.e(response.body);
      if(response.statusCode==200 || response.statusCode==201)
      {
        return VideoUploadResponseModal.fromJson(response.body!);
      }
    }  catch (e)
  {
        return VideoUploadResponseModal(data: VideoUploadData(msg: "Could not upload video",resource: null));
  }
  return VideoUploadResponseModal(data: VideoUploadData(msg: "Could not upload video",resource: null));
}
Future<VideoUploadResponseModal> uploadFileData({required String token,required VideoRequestModal videoRequestModal})async
{
  try{
    Response<Map<String,dynamic>> response=await post('$baseURL$addresource',videoRequestModal.toJson(),headers: {"Authorization":"Bearer $token"});
      logger.e(response.body);
      if(response.statusCode==200 || response.statusCode==201)
      {
        return VideoUploadResponseModal.fromJson(response.body!);
      }
    }  catch (e)
  {
        return VideoUploadResponseModal(data: VideoUploadData(msg: "Could not upload video",resource: null));
  }
  return VideoUploadResponseModal(data: VideoUploadData(msg: "Could not upload video",resource: null));
}

Future<FileUploadResponse> uploadFile({required String token,required File file  })async
{
 var formData = dio.FormData.fromMap({
  
  'file': await dio.MultipartFile.fromFile(file.path,filename: file.path.substring(file.path.lastIndexOf("/")+1)),
});

try {
  dio.Response<Map<String,dynamic>> response = await dio.Dio().post('$baseURL$createchannel', data: formData,options: dio.Options(contentType: "multipart/form-data",headers:{"Authorization":"Bearer $token"}));
     logger.e(response.data);
     if(response.statusCode==200 || response.statusCode==201)
     {
        return FileUploadResponse.fromJson(response.data!);
     }
     else
     {
      return FileUploadResponse.fromJson(response.data!);
     }
} on Exception catch (e) {
  e.printError();
  return FileUploadResponse(data: null);
}
  
}
Future<SubscriberListModal> getChannelSubcribers({required String token,required int channelId})async
{
 logger.i("Channel id: $channelId");

try {
  Response<Map<String,dynamic>> response = await get('$baseURL$channelsubscribers$channelId',headers: {"Authorization":"Bearer $token"});
     logger.e(response.body);
     if(response.statusCode==200 || response.statusCode==201)
     {
        return SubscriberListModal.fromJson(response.body!);
     }
     else
     {
      return SubscriberListModal.fromJson(response.body!);
     }
} on Exception catch (e) {
  e.printError();
  return SubscriberListModal(data: null);
}
  
}
}


 
class GeneralResponse {
  String? _msg;
  bool? _status;

  GeneralResponse({String? msg, bool? status}) {
    if (msg != null) {
      _msg = msg;
    }
    if (status != null) {
      _status = status;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = _msg;
    data['status'] = _status;
    return data;
  }


  
}