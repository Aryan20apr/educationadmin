import 'dart:async';
import 'dart:io';



import 'package:educationadmin/Modals/BannersResponse.dart';
import 'package:educationadmin/Modals/BannersUploadResponse.dart';
import 'package:educationadmin/Modals/ChannelCreationResponse.dart';
import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/Modals/CreateNoticeResponse.dart';
import 'package:educationadmin/Modals/EditResourceModal.dart';
import 'package:educationadmin/Modals/FileResourcesModal.dart';
import 'package:educationadmin/Modals/FileUploadResponseModal.dart';
import 'package:educationadmin/Modals/ImageUploadResponse.dart';
import 'package:educationadmin/Modals/LoginModal.dart';
import 'package:educationadmin/Modals/NoticesResponse.dart';
import 'package:educationadmin/Modals/PasswordResetResponse.dart';
import 'package:educationadmin/Modals/PhoneVerificationModal.dart';
import 'package:educationadmin/Modals/ProfileUpdateResponse.dart';
import 'package:educationadmin/Modals/SignupResponseModal.dart';
import 'package:educationadmin/Modals/SubsciberModal.dart';
import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/Modals/VideoRequestModal.dart';
import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/Modals/VideoUploadResponse.dart';
import 'package:educationadmin/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' as dio;
import '../../Modals/GeneralResponse.dart';
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
  final String userchannels="channels/subscribed";
  final String editchannel="channels/edit";
  final String deletechannel="channels/delete/";
  final String addconsumerfromcreator="subscription/subscribe/creator";
  final String addresource="resources/create";
  final String channelsubscribers="analytics/channel/myConsumers/";
  final String uploadpdf="resources/upload/pdf";
  final String editresource="resources/edit/";
  final String deleteResource="resources/delete/";
  final String uploadprofileimage="auth/upload";
  final String resetpassword="auth/forgot/password";
  final String createbanner="banners/create";
  final String getbanners="banners";
  final String getnotices="notice/get/notices";
  final String createnotice="notice/create";
  final String updateprofile="auth/profile/edit";
  final String deletenotice="notice/delete/";
  final String deletebanner="banners/delete/";
  final String startstream="resources/live/start/";
  final String endstream="resources/live/end/";
  final String removesubscriber="subscription/unsubscribe/creator/";

  final Logger logger=Logger();
  Future<SignupResponseModal> signUp(SignupModal model) async {
//     Response<Map<String,dynamic>> response = await post('$baseURL$signup', model.toJson());
//     logger.e(response.body.toString());
//     if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created) {
//       return SignupResponseModal.fromJson(response.body!);
//     } else {


// TODO: "Handle signup error ";
//       return null; 
//       //return SignupErrorModal.fromJson(response.body!);
//     }

  Map<String,dynamic> map=model.toJson();
  map['role']='creator';
  try {
  Response<Map<String,dynamic>> response = await post('$baseURL$signup', map);
  logger.e(response.body.toString());
  if(response.body!=null)
  
  {if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created)
  {
      return SignupResponseModal.fromJson(response.body!);
  }
  else
  {
    Map<String,dynamic> map=response.body!['error'];
    return SignupResponseModal(data: null,msg:map['msg'],statusCode: map['statusCode']);
  }
  }
  else
  {
    return SignupResponseModal(data: null,msg: 'Some error occurred, try again later.',statusCode: 0);
  }
} on Exception catch (e) {
  e.printError();
  return SignupResponseModal(data: null,msg: 'Some error occurred, try again later.',statusCode: 0);
}
  }

 Future<SignupResponseModal> login(LoginModal model) async {
    try {
  Response<Map<String,dynamic>> response = await post('$baseURL$signin', model.toJson());
  logger.e(response.body.toString());
  if(response.body!=null)
  
  {if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created)
  {
      return SignupResponseModal.fromJson(response.body!);
  }
  else
  {
    Map<String,dynamic> map=response.body!['error'];
    return SignupResponseModal(data: null,msg:map['msg'],statusCode: map['statusCode']);
  }
  }
  else
  {
    return SignupResponseModal(data: null,msg: 'Some error occurred, try again later.',statusCode: 0);
  }
} on Exception catch (e) {
  e.printError();
  return SignupResponseModal(data: null,msg: 'Some error occurred, try again later.',statusCode: 0);
}
    // if(response.body!=null)
    // {
    // if (response.body!["statusCode"]==Status.positive||response.body!["statusCode"]==Status.created) {
    //   return SignupResponseModal.fromJson(response.body!);
  
    // }
    //   else if(response.body!["statusCode"]==Status.failed)
    //   {
    //   return SignupResponseModal(msg: response.body!["msg"]);}
    //   // ignore: curly_braces_in_flow_control_structures
    //   else 
    //   {return SignupResponseModal(msg: "Could not login");}
    // }
    //  else {
     
    //   return SignupResponseModal(msg: "Could not login");
    // }
  }

Future<OTPModal?> sendOTP({required PhoneModal phone}) async {
    try {
  Response<Map<String,dynamic>> response = await post('$baseURL$sendotp', phone.toJson());
logger.e(response.body);
    if (response.body!=null) {
      
      return OTPModal.fromJson(response.body!);
    } else {
      return OTPModal();


    }
    } 
on Exception catch (e) {
e.printError();
}
return OTPModal();
    
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
  try {
  Response<Map<String,dynamic>> response = await get('$baseURL$channels',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
     return ChannelListModal.fromJson(response.body!);
} on Exception catch (e) {
  e.printError();
return ChannelListModal();
  // TODO
}
  
  }
Future<ChannelListModal> getCreatorList({String? token}) async
{
  try {
  try {
  Response<Map<String,dynamic>> response = await get('$baseURL$creatorChannels',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
    if(response.body!=null) {
      return ChannelListModal.fromJson(response.body!);
    }
    else {
      return ChannelListModal();
    }
} on Exception catch (e) {
  e.printError();
  return ChannelListModal();
}
} on Exception catch (e) {
  e.printError();
  return ChannelListModal();
}
  }
Future<ChannelListModal> getUserChannelList({String? token,required int userid}) async
{
  try {
  Response<Map<String,dynamic>> response = await get('$baseURL$userchannels',headers: {"Authorization":"Bearer $token"});
    if(response.body!=null) {
      return ChannelListModal.fromJson(response.body!);
    } else
   {
    return ChannelListModal();
   }
} on Exception catch (e) {
  e.printError();
  return ChannelListModal();
}
  }

Future<FileResourcesData> getChannelFiles({String? token, required int channelId}) async
{
Response<Map<String,dynamic>> response = await get('$baseURL$channelfiles$channelId',headers: {"Authorization":"Bearer $token"});
    logger.e(response.body);
   return FileResourcesData.fromJson(response.body!);
}

Future<VideoResourcesData> getChannelVideo({String? token, required int channelId}) async
{

  try {
  Response<Map<String,dynamic>> response = await get('$baseURL$channelvideos$channelId',headers: {"Authorization":"Bearer $token"});
      logger.e(response.body);
      if(response.body!=null) {
        return VideoResourcesData.fromJson(response.body!);
      }
      else
      {
        return VideoResourcesData();
      }
} on Exception catch (e) {
  // TODO
    return VideoResourcesData();
}
  


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
Future<CreateChannelResponseModal> editChannel({required bool paidChannel,required int price,required String? token, XFile? file, required String name,required int channelid})async
{
   var formData;
   if(file!=null)
   { 
   formData = dio.FormData.fromMap({
  
  'file': await dio.MultipartFile.fromFile(file.path,filename: file.name),
    'name': name,
     "isCompletelyPaid": paidChannel,
     "price" : price

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
      logger.e("Channel Delete Response is ${response.body}");
      if(response.statusCode==200 ||response.statusCode==201)
      {
        return true;

      }
      else
      {
        return false;
      }
  }
  Future<GeneralResponse2> subscribeByCreator({required String token,required int channelId,required int consumerId})async
  {
     try {
  Response<Map<String,dynamic>> response=await post("$baseURL$addconsumerfromcreator/$channelId/$consumerId",{},headers: {"Authorization":"Bearer $token"});
   logger.i(response.body);
   if(response.statusCode==200 ||response.statusCode==201)
   {
    if(response.body!=null)
    {
  
     return GeneralResponse2.fromJson(response.body!);
    }
    else
    {
      return GeneralResponse2();
    }
   }
  
} on Exception catch (e) {
  e.printError();
   return GeneralResponse2();
}
return   GeneralResponse2();
  }
   Future<GeneralResponse2> removeSubscriber({required String token,required int channelId,required int consumerId})async
  {
     try {
  Response<Map<String,dynamic>> response=await post("$baseURL$removesubscriber$channelId/$consumerId",{},headers: {"Authorization":"Bearer $token"});
   logger.i(response.body);
   if(response.statusCode==200 ||response.statusCode==201)
   {
    if(response.body!=null)
    {
  
     return GeneralResponse2.fromJson(response.body!);
    }
    else
    {
      return GeneralResponse2();
    }
   }
  
} on Exception catch (e) {
  e.printError();
   return GeneralResponse2();
}
return   GeneralResponse2();
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
  dio.Response<Map<String,dynamic>> response = await dio.Dio().post('$baseURL$uploadpdf', data: formData,options: dio.Options(contentType: "multipart/form-data",headers:{"Authorization":"Bearer $token"}));
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
Future<EditResourceModal> editResource({required String token,required int resourceId,required String title })async
{
  try {
  Response response=await put('$baseURL$editresource$resourceId', {"title" :title },headers: {"Authorization":"Bearer $token"});
  logger.e("Edit resource response ${response.body}");
  return EditResourceModal.fromJson(response.body);
} on Exception catch (e) {
  e.printError();
  return EditResourceModal(data: EditedData(msg: "Could not update ",updatedResource: null));
}
}
Future<GeneralResponse> deleteresource({required String token,required int resourceId})async
{
  try {
  Response response=await delete('$baseURL$deleteResource$resourceId', headers: {"Authorization":"Bearer $token"});
  logger.e("Delete resource response ${response.body}");
  return GeneralResponse(msg: "Successfully deleted",status: true);
} on Exception catch (e) {
  e.printError();
  return GeneralResponse(msg: 'Could not delete the resource',status: false);
}
}

Future<ImageUploadResponse> uploadProfileImage({required String token,required XFile? file})async
{
 var formData = dio.FormData.fromMap({
  
  'file': await dio.MultipartFile.fromFile(file!.path,filename: file.name),
  
    
});




   try {
    //Response<Map<String,dynamic>> response=await post('$baseURL$createchannel', formData,contentType:"multipart/form-data",headers: {"Authorization":"Bearer $token"} );
    dio.Response<Map<String,dynamic>> response = await dio.Dio().post('$baseURL$uploadprofileimage', data: formData,options: dio.Options(contentType: "multipart/form-data",headers:{"Authorization":"Bearer $token"}));
    print(response.data);
    if (response.statusCode == 200||response.statusCode==201) {
      print('Success: ${response.data}');
      return ImageUploadResponse.fromJson(response.data!);
    } else {
      return ImageUploadResponse();
    }
  } catch (e) {
    print('Error: $e');
   
  }
   return ImageUploadResponse();
}


Future<PasswordResetResponse> resetPassword({required String phone,required String password})async{

  Map<String,dynamic> body={
    "phone": phone,
    "password": password
};
  try {
  Response<Map<String,dynamic>> response=await post("$baseURL$resetpassword",body);
  logger.e(response.body);
  if(response.body!=null) {

    return PasswordResetResponse.fromJson(response.body!);
  }
  else
  {
    return PasswordResetResponse();
  }
} on Exception catch (e) {
  
  e.printError();
  return PasswordResetResponse();
}

}

Future<BannersResponse> getBanners({required String jwt})async
{
  try {
  Response<Map<String,dynamic>> response=await get("$baseURL$getbanners",headers:{"Authorization":"Bearer $jwt"});
  logger.e(response.body);
  if(response.body!=null) {

    return BannersResponse.fromJson(response.body!);
  }
  else
  {
    return BannersResponse();
  }
} on Exception catch (e) {
  
  e.printError();
  return BannersResponse();
}
}
Future<BannersUploadResponse> uploadBannerImage({required String token,required XFile? file})async
{
 var formData = dio.FormData.fromMap({
  
  'file': await dio.MultipartFile.fromFile(file!.path,filename: file.name),
  
    
});




   try {
    //Response<Map<String,dynamic>> response=await post('$baseURL$createchannel', formData,contentType:"multipart/form-data",headers: {"Authorization":"Bearer $token"} );
    dio.Response<Map<String,dynamic>> response = await dio.Dio().post('$baseURL$createbanner', data: formData,options: dio.Options(contentType: "multipart/form-data",headers:{"Authorization":"Bearer $token"}));
    print(response.data);
    if (response.statusCode == 200||response.statusCode==201) {
      print('Success: ${response.data}');
      
      return BannersUploadResponse.fromJson(response.data!);
    } else {
      return BannersUploadResponse();
    }
  } catch (e) {
    print('Error: $e');
   
  }
   return BannersUploadResponse();
}
Future<NoticesResponse> getNotices({required String token})async
{
  try {
  Response response=await get("$baseURL$getnotices",headers:{"Authorization":"Bearer $token"});
  logger.e(response.body);
  if(response.body!=null)
  {
    return NoticesResponse.fromJson(response.body);
  }
  else
  {
    return NoticesResponse();
  }
} on Exception catch (e) {
  e.printError();
  return NoticesResponse();
}
  

}

Future<CreateNoticeResponse> createNotices({required bool isLimited,
required String title,required String description,required int channelId,required String token})async
{
    Map<String,dynamic> body={
      "title":title,
      "description":description,
      "channelId":channelId
    };
    if(isLimited==false)
    {
      body.remove('channelId');
    }
  try {
  Response response=await post("$baseURL$createnotice",body,headers:{"Authorization":"Bearer $token"});
  if(response.body!=null)
  {
    logger.e(response.body);
    return CreateNoticeResponse.fromJson(response.body);
  }
  else
  {
    return CreateNoticeResponse();
  }
} on Exception catch (e) {
  e.printError();
  return CreateNoticeResponse();
}
  


}
Future<GeneralResponse2> updateProfile({required SignupModal signupModal,required String token,required String image})async
{
Map<String,dynamic> map=signupModal.toJson();
map.remove('password');
map.remove('phone');
map.addAll({'image': image});
logger.e("Update profile:$map");
try {
  Response response=await put("$baseURL$updateprofile",map,headers:{"Authorization":"Bearer $token"});
  if(response.body!=null)
  {
  logger.e(response.body);
  return GeneralResponse2.fromJson(response.body);}
} on Exception catch (e) {
  e.printError();
}
return GeneralResponse2();

}

Future<GeneralResponse2> deleteNotice({required int id,required String token})async
{
  try {
  Response response=await delete("$baseURL$deletenotice$id",headers: {"Authorization":"Bearer $token"});
  if(response.body!=null)
  {
    return GeneralResponse2.fromJson(response.body);
  }
  else
  {
    return GeneralResponse2();
  }
} on Exception catch (e) {
  e.printError();
}
return GeneralResponse2();
}
Future<GeneralResponse2> deleteBanner({required int id,required String token})async
{
  try {
  Response response=await delete("$baseURL$deletebanner$id",headers: {"Authorization":"Bearer $token"});
  if(response.body!=null)
  {
    return GeneralResponse2.fromJson(response.body);
  }
  else
  {
    return GeneralResponse2();
  }
} on Exception catch (e) {
  e.printError();
}
return GeneralResponse2();
}
  Future<GeneralResponse2> startStream({required int id,required String token,required String title})async
  {
       Map<String,dynamic> body={"title":title};
     try {
  Response response=await put("$baseURL$startstream$id",body,headers: {"Authorization":"Bearer $token"});
   logger.i(response.body);
  if(response.body!=null)
  {
   
    return GeneralResponse2.fromJson(response.body);
  }
  else
  {
    return GeneralResponse2();
  }
} on Exception catch (e) {
  e.printError();
}
return GeneralResponse2();
  }
  Future<GeneralResponse2> endStream({required int id,required String token,required String title })async
  {
    Map<String,dynamic> body={"title":title};
     try {
  Response response=await put("$baseURL$endstream$id",body,headers: {"Authorization":"Bearer $token"});
   logger.i(response.body);
  if(response.body!=null)
  {
   
    return GeneralResponse2.fromJson(response.body);
  }
  else
  {
    return GeneralResponse2();
  }
} on Exception catch (e) {
  e.printError();
}
return GeneralResponse2();
  }
}


 
