





import 'package:educationadmin/Modals/FileResourcesModal.dart';
import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/utils/core/NetworkChecker.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

import 'AuthenticationController.dart';


class ChannelResourceController extends GetxController
{

  
  AuthenticationManager authenticationManager=Get.find<AuthenticationManager>();
   Rx<FileResourcesData> fileData=FileResourcesData().obs;
   Rx<VideoResourcesData> videoData=VideoResourcesData().obs;
 
  NetworkService networkService=Get.find<NetworkService>();


  

  Future<bool> getChannelFiles({required int channelId}) async
  {
      NetworkChecker networkchecker=NetworkChecker();
      bool check=await networkchecker.checkConnectivity();
    
    if(check==false)
    {
      Get.showSnackbar(const GetSnackBar(
          message: 'No Internet Connection',
          duration: Duration(seconds: 5),
        ));
        Logger().i("Get snackbar displayed");
        return false;}
     fileData.value= await networkService.getChannelFiles(token:await authenticationManager.getToken(),channelId: channelId);
      return false;
      }
   

  

  Future<bool> getChannelVideos({required int channelId}) async
  {
    NetworkChecker networkchecker=NetworkChecker();
      bool check=await networkchecker.checkConnectivity();
    
    if(check==false)
    {
      Get.showSnackbar(const GetSnackBar(
          message: 'No Internet Connection',
          duration: Duration(seconds: 5),
        ));
        Logger().i("Get snackbar displayed");
        return false;}
    videoData.value= await networkService.getChannelVideo(token:await authenticationManager.getToken(),channelId: channelId);
    return true;
  }
}