
import 'package:educationadmin/Modals/NoticesResponse.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/core/NetworkChecker.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';

import '../../Modals/CreateNoticeResponse.dart' as notice;
class NoticesController extends GetxController
{
RxBool isLoading=false.obs;
Rx<Data> notices=Data().obs;
NetworkService networkService=Get.put(NetworkService());
AuthenticationManager authenticationManager=Get.put(AuthenticationManager());
  Future<bool> getNotices()async
  {
    NetworkChecker networkChecker=NetworkChecker();
   bool isAvailable=await networkChecker.checkConnectivity();
   if(!isAvailable)
   {
      String? token=await authenticationManager.getToken();
      NoticesResponse response=await networkService.getNotices(token: token!);
      if(response.data!=null)
      {
          notices.value=response.data!;
      }
      else
      {
        return false;
      }
      return true;
   }
   else
   {
    Get.showSnackbar(const GetSnackBar(message: "Cannot obtain notices",duration: Duration(seconds: 3),));
   }
   return false;
  }

  Future<void> createNotice({required String title,required String description,required int channelId}) async
  {
    NetworkChecker networkChecker=NetworkChecker();
   bool isAvailable=await networkChecker.checkConnectivity();
   if(!isAvailable)
   {
      String? token=await authenticationManager.getToken();
      notice.CreateNoticeResponse  response=await networkService.createNotices(token: token!, title:title, description: description, channelId: channelId);
      if(response.data!=null)
      {
         Get.showSnackbar(const GetSnackBar(title: "Notice created successfully",duration: Duration(seconds: 3),));
      }
      else
      {
        Get.showSnackbar(const GetSnackBar(title: "Could not create notice",duration: Duration(seconds: 3),));
      }
   
   }
   else
   {
    Get.showSnackbar(const GetSnackBar(message: "Cannot create notices",duration: Duration(seconds: 3),));


  }
}
}