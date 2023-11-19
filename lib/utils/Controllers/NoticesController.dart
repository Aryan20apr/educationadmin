
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
RxList<bool> isExpanded=RxList<bool>();
NetworkService networkService=Get.put(NetworkService());
AuthenticationManager authenticationManager=Get.put(AuthenticationManager());
  Future<bool> getNotices()async
  {
    NetworkChecker networkChecker=NetworkChecker();
   bool isAvailable=await networkChecker.checkConnectivity();
   if(isAvailable)
   {
      String? token=await authenticationManager.getToken();
      NoticesResponse response=await networkService.getNotices(token: token!);
      if(response.data!=null)
      {
        int len=response.data!.notices!.length;
        List<bool> list=List<bool>.filled(len, false);
        isExpanded.value.assignAll(list);
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
  {isLoading.value=true;
    NetworkChecker networkChecker=NetworkChecker();
   bool isAvailable=await networkChecker.checkConnectivity();
   if(isAvailable)
   {
      String? token=await authenticationManager.getToken();
      notice.CreateNoticeResponse  response=await networkService.createNotices(token: token!, title:title, description: description, channelId: channelId);
      isLoading.value=false;
      if(response.data!=null)
      {
         Get.showSnackbar(const GetSnackBar(message: "Notice created successfully",duration: Duration(seconds: 3),));
      }
      else
      {
        Get.showSnackbar(const GetSnackBar(message: "Could not create notice",duration: Duration(seconds: 3),));
      }
   
   }
   else
   {
    Get.showSnackbar(const GetSnackBar(message: "Cannot create notices",duration: Duration(seconds: 3),));


  }
}
void updateExpansion({required int index,required bool status})
{
isExpanded[index]=status;
}
}