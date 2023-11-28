

import 'package:educationadmin/Modals/EditResourceModal.dart';
import 'package:educationadmin/Modals/ProfileUpdateResponse.dart';
import 'package:educationadmin/Modals/SubsciberModal.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:logger/logger.dart';
import 'package:educationadmin/Modals/ChannelListModal.dart' as channellist;
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/core/NetworkChecker.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';

import '../../../Modals/FileResourcesModal.dart';
import '../../../Modals/GeneralResponse.dart';
import '../../../Modals/VideoResourcesModal.dart';

class CreaterChannelsController extends GetxController{

  final AuthenticationManager _authmanager = Get.find<AuthenticationManager>();
  final NetworkService networkService=Get.find<NetworkService>();
  final UserDetailsManager userDetailsManager=Get.put(UserDetailsManager());

final Rx<channellist.Data> channelData=channellist.Data().obs;


AuthenticationManager authenticationManager=Get.find<AuthenticationManager>();
NetworkChecker networkChecker=NetworkChecker();

  Rx<FileResourcesData> fileData=FileResourcesData().obs;
  Rx<VideoResourcesData> videoData=VideoResourcesData().obs;
 Rx<SubcriberData> consumerList=SubcriberData().obs;
    RxList<Videos> normalVideos=RxList.empty();
   RxList<Videos> liveVideos = RxList.empty();
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
        Logger().i("Get snackbar displayed");
        return false;}
    /*videoData.value*/ VideoResourcesData resourcesData= await networkService.getChannelVideo(token:await authenticationManager.getToken(),channelId: channelId);
    if(resourcesData.data!=null)
    //videoData.refresh();
    {
      videoData.value=resourcesData;
    List<Videos> videos=resourcesData.data!.videos!;
    liveVideos.clear();
    normalVideos.clear();
    for (var element in videos) {
      if(element.isLive!=null&&element.isLive!)
    {
        liveVideos.add(element);
    }
    else
    {
      normalVideos.add(element);
    }
    }
    liveVideos.refresh();
    normalVideos.refresh();
    return true;
    }

    return false;
  }

  // Future<bool> getChannelVideos({required int channelId}) async
  // {
  //   NetworkChecker networkchecker=NetworkChecker();
  //     bool check=await networkchecker.checkConnectivity();
    
  //   if(check==false)
  //   {
  //     Get.showSnackbar(const GetSnackBar(
  //         message: 'No Internet Connection',
  //         duration: Duration(seconds: 5),
  //       ));
  //      logger.i("Get snackbar displayed");
  //       return false;}
  //   videoData.value= await networkService.getChannelVideo(token:await authenticationManager.getToken(),channelId: channelId);
  //   return true;
  // }


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
     if(channelListModal.data==null||channelListModal.data!.channels==null) {
       return false;
     }
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

  Future<void> startStream({required int channelId,required int id,required String title }) async
  {
NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      Get.showSnackbar(const GetSnackBar(message: 'Could not start live streaming',duration: Duration(seconds:3),));
      //return false;
    }
    String? token=await _authmanager.getToken();

    GeneralResponse2 generalResponse=await networkService.startStream(id: id, token: token!, title: title);
    if(generalResponse.data!=null)
    {
      if(generalResponse.data!.status==true)
    {
      getChannelVideos(channelId: channelId);
       Get.showSnackbar(const GetSnackBar(title: 'Live streaming started',message: 'Consumers can now see your live video.',duration: Duration(seconds:3),));
    }
    else
    {
       Get.showSnackbar(const GetSnackBar(title: 'Live streaming could not be started',message: 'Some error occurred.',duration: Duration(seconds:3),));
    }
    }
    else
    {
       Get.showSnackbar(const GetSnackBar(title: 'Live streaming could not be started',message: 'Some error occurred.',duration: Duration(seconds:3),));
    }
  }

    Future<void> endStream({required int channelId,required int id,required String title }) async
  {
    NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      Get.showSnackbar(const GetSnackBar(message: 'Could not delete',duration: Duration(seconds:3),));
      //return false;
    }
    String? token=await _authmanager.getToken();
    GeneralResponse2 generalResponse=await networkService.endStream(id: id, token: token!, title: title);
    if(generalResponse.data!=null)
    {
      if(generalResponse.data!.status==true)
    {
      getChannelVideos(channelId: channelId);
       Get.showSnackbar(const GetSnackBar(message: 'Live streaming stopped',duration: Duration(seconds:3),));
    }
    else
    {
       Get.showSnackbar(const GetSnackBar(message: 'Live streaming could not be stopped',duration: Duration(seconds:3),));
    }
    }
    else
    {
        Get.showSnackbar(const GetSnackBar(message: 'Live streaming could not be stopped',duration: Duration(seconds:3),));
    }
  }

  Future<bool> removeSubscriber({required int channeId,required int index}) async
  {
    isLoading.value=true;
    if(await networkChecker.checkConnectivity()==false)
    {
      isLoading.value=false;
      Get.back();
      Get.showSnackbar(const GetSnackBar(message: 'Could not remove subscriber',duration: Duration(seconds: 3),));

    }
    String? token=await authenticationManager.getToken();
    if(token!=null){
   GeneralResponse2 generalResponse= await networkService.removeSubscriber(channelId:channeId,consumerId:int.parse(consumerList.value.consumers![index].phone!),token:token);
   isLoading.value=false;  
   //logger.i(generalResponse.data);
   if(generalResponse.data==null)
   {
    Get.back();

    
    Get.showSnackbar(const GetSnackBar(message: 'Could not remove the subscriber',duration: Duration(seconds:3 ),));
    
      return false;
   }   
   else
   {Get.back();
     Get.showSnackbar(GetSnackBar(message: generalResponse.data!.msg!,duration: const Duration(seconds:3 ),));
    return true;
   }
  }
  else
  {
    Get.showSnackbar(const GetSnackBar(message: 'Could not remove the subscriber',duration: Duration(seconds:3 ),));
    return false;
  }
}
}