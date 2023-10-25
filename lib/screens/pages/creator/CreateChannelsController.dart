

import 'package:logger/logger.dart';
import 'package:educationadmin/Modals/ChannelListModal.dart' as channellist;
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/core/NetworkChecker.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';

import '../../../Modals/FileResourcesModal.dart';
import '../../../Modals/VideoResourcesModal.dart';

class CreaterChannelsController extends GetxController{

  final AuthenticationManager _authmanager = Get.find<AuthenticationManager>();
  final NetworkService networkService=Get.find<NetworkService>();
final channelData=channellist.Data().obs;

AuthenticationManager authenticationManager=Get.find<AuthenticationManager>();
  final fileData=FileResourcesData().obs;
  final videoData=VideoResourcesData().obs;
 
 Logger logger=Logger();
 

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
        logger.i("Get snackbar displayed");
        return false;}
     fileData.value= await networkService.getChannelFiles(token:await authenticationManager.getToken(),channelId: channelId);
      return true;
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
       logger.i("Get snackbar displayed");
        return false;}
    videoData.value= await networkService.getChannelVideo(token:await authenticationManager.getToken(),channelId: channelId);
    return true;
  }

  Future<bool> getChannels() async
  {
    logger.e("Getting channels for creater");
    NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      return false;
    }
    String? token=await _authmanager.getToken();
    if(token!=null)
    {
     channellist.ChannelListModal channelListModal=await   networkService.getCreatorList(token: token);
     channelData.value=channelListModal.data!;
    }
    return true;
  }

  Future<bool> deleteChannel({required int channelId})async
  {
      NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      return false;
    }
    String? token=await _authmanager.getToken();
    if(token!=null)
    {
    bool isDeleted=await   networkService.deleteChannel(token: token,channelId: channelId);
     return isDeleted;
    }
    return false;
  }
}