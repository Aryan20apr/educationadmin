
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:educationadmin/Modals/FileUploadResponseModal.dart';
import 'package:educationadmin/Modals/VideoRequestModal.dart';
import 'package:educationadmin/Modals/VideoUploadResponse.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/core/NetworkChecker.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Modals/GeneralResponse.dart';
class ChannelOptionsController extends GetxController
{
  final AuthenticationManager authenticationManager=Get.put(AuthenticationManager());
  final NetworkService networkService=NetworkService();
 final NetworkChecker networkChecker=NetworkChecker();
  RxBool isLoading=false.obs;
 RxString phoneNumber = ''.obs;
  RxBool isVideoPaid=false.obs;
  RxBool isFilePaid=false.obs;
  RxString filePath="".obs;
  Rx<DateTime> selectedDateTime=DateTime.now().obs;
  
  Logger logger=Logger();
  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  Future<bool> addSubscriber({required int channeId}) async
  {
    isLoading.value=true;
    String? token=await authenticationManager.getToken();
    if(token!=null){
   GeneralResponse generalResponse= await networkService.subscribeByCreator(channelId:channeId,consumerId:int.parse(phoneNumber.value),token:token);
   isLoading.value=false;  
   print(generalResponse.msg);
   if(generalResponse.status==false)
   {
    Get.back();

    
    Get.showSnackbar(GetSnackBar(message:generalResponse.msg,duration: const Duration(seconds:3 ),));
    
      return false;
   }   
   else
   {Get.back();
     Get.showSnackbar(GetSnackBar(message: generalResponse.msg,duration: const Duration(seconds:3 ),));
    return true;
   }
  }
  else
  {
    return false;
  }
}
Future<void> uploadVideo({required VideoRequestModal videoRequestModal})async
{
  Get.back();
   
   if(await networkChecker.checkConnectivity()==false)
   {
    
    
    Get.showSnackbar(const GetSnackBar(message:"No internet connection",duration: Duration(seconds:3)));
   }
  
  String? token=await authenticationManager.getToken();
  try {
  VideoUploadResponseModal videoUploadResponseModal=await networkService.uploadVideo(token: token!, videoRequestModal: videoRequestModal);
   
 
  
  if(videoUploadResponseModal.data!.resource!=null)
  {
   
    Get.showSnackbar(GetSnackBar(message: videoUploadResponseModal.data!.msg,duration: const Duration(seconds:3 ),));
  }
  else
  {
    
    Get.showSnackbar(GetSnackBar(message: videoUploadResponseModal.data!.msg,duration: const Duration(seconds:3 ),));
  }
} on Exception catch (e) {
  e.printError();
  Get.showSnackbar( const GetSnackBar(message:'Could not upload video',duration: Duration(seconds: 3),));
}

}

Future<void> uploadLiveVideo({required VideoRequestModal videoRequestModal})async
{
  Get.back();
   
   if(await networkChecker.checkConnectivity()==false)
   {
    
    
    Get.showSnackbar(const GetSnackBar(message:"No internet connection",duration: Duration(seconds:3)));
   }
  
  String? token=await authenticationManager.getToken();
  try {
    
    videoRequestModal.isStreaming=false;
    videoRequestModal.startDate='${selectedDateTime.value.toIso8601String()}Z';
    videoRequestModal.startTime='${selectedDateTime.value.toIso8601String()}Z';
    videoRequestModal.isLive=true;
    logger.i("Date and Time ${ videoRequestModal.startDate}  ${videoRequestModal.startTime}");
  VideoUploadResponseModal videoUploadResponseModal=await networkService.uploadVideo(token: token!, videoRequestModal: videoRequestModal);
   
 
  
  if(videoUploadResponseModal.data!.resource!=null)
  {
   
    Get.showSnackbar(GetSnackBar(message: videoUploadResponseModal.data!.msg,duration: const Duration(seconds:3 ),));
  }
  else
  {
    
    Get.showSnackbar(GetSnackBar(message: videoUploadResponseModal.data!.msg,duration: const Duration(seconds:3 ),));
  }
} on Exception catch (e) {
  e.printError();
  Get.showSnackbar( const GetSnackBar(message:'Could not upload video',duration: Duration(seconds: 3),));
}

}

Future<void> uploadFile({required title,required int channeId})async
{
  Get.back();
String? token=await authenticationManager.getToken();
FileUploadResponse fileUploadResponse=await networkService.uploadFile(token: token!, file: File(filePath.value));
if(fileUploadResponse.data!=null&&fileUploadResponse.data!=null)
{
  VideoRequestModal fileRequestModal= VideoRequestModal(title:title,link: fileUploadResponse.data!.url,isPaid:isFilePaid.value.toString(),type: 'file',channelId: channeId );
   VideoUploadResponseModal videoUploadResponseModal=await networkService.uploadFileData(token: token, videoRequestModal: fileRequestModal);
  if(videoUploadResponseModal.data!.resource!=null)
  {
    
    Get.showSnackbar(GetSnackBar(message: videoUploadResponseModal.data!.msg,duration: const Duration(seconds:3 ),));
  }
  else
  {
    
    Get.showSnackbar(GetSnackBar(message: videoUploadResponseModal.data!.msg,duration: const Duration(seconds:3 ),));
  }
}
else
{
    
    Get.showSnackbar(const GetSnackBar(message: 'Could not upload file',duration: Duration(seconds:3 ),));
}
}

}