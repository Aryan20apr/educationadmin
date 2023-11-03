

import 'package:educationadmin/Modals/EditResourceModal.dart';
import 'package:educationadmin/Modals/SubsciberModal.dart';
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
final Rx<channellist.Data> channelData=channellist.Data().obs;


AuthenticationManager authenticationManager=Get.find<AuthenticationManager>();
  final fileData=FileResourcesData().obs;
  final videoData=VideoResourcesData().obs;
  final consumerList=SubcriberData().obs;
 Logger logger=Logger();
  RxBool isLoading=false.obs;

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
     if(channelListModal.data==null)
     return false;
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

  Future<bool> getChannelSubscribers({required int channelId })async
  {
    isLoading.value=true;
     NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      Get.showSnackbar(const GetSnackBar(message: 'Could not obtain required data',duration: Duration(seconds:3),));
      return false;
    }
    String? token=await _authmanager.getToken();
    if(token!=null)
    {
     SubscriberListModal subscriberListModal=await networkService.getChannelSubcribers(token: token, channelId:channelId );
     consumerList.value=subscriberListModal.data!;
     isLoading.value=false;
     return true;
    }
    return false;

  }

  Future<bool> deleteSubscriber({required int subscriberId})async
  {
    return true;
  }

  Future<bool> editResource({required String filename,required int resourceId}) async{

     NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      Get.showSnackbar(const GetSnackBar(message: 'Could not update',duration: Duration(seconds:3),));
      return false;
    }
    String? token=await _authmanager.getToken();
    EditResourceModal editResourceModal=await networkService.editResource(token: token!,resourceId:resourceId,title: filename );
    if(editResourceModal.data!.updatedResource==null)
    {
      Get.back();
      Get.showSnackbar(const GetSnackBar(message:"Could not update successfully",duration: Duration(seconds: 3),));
      
      return false;
    }
    else
    {
      Get.back();
      Get.showSnackbar(const GetSnackBar(message:"Resource updated successfully",duration: Duration(seconds: 3),));
      
      return true;
    }
  }

  Future<bool> deleteResource({required int resourceId }) async
  {
     NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      Get.showSnackbar(const GetSnackBar(message: 'Could not delete',duration: Duration(seconds:3),));
      return false;
    }
    String? token=await _authmanager.getToken();
   GeneralResponse editResourceModal=await networkService.deleteresource(token: token!,resourceId:resourceId, );
    if(editResourceModal.status==false)
    {
       Get.back();
      Get.showSnackbar(const GetSnackBar(message:"Could not delete successfully",duration: Duration(seconds: 3),));
     
      return false;
    }
    else
    {
       Get.back();
      Get.showSnackbar(const GetSnackBar(message:"Resource delete successfully",duration: Duration(seconds: 3),));
     
      return true;
    }
  }
}