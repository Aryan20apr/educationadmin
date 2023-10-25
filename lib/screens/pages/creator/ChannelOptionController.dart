import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';
class ChannelOptionsController extends GetxController
{
  final AuthenticationManager authenticationManager=Get.put(AuthenticationManager());
  final NetworkService networkService=NetworkService();
  RxBool isLoading=false.obs;
 RxString phoneNumber = ''.obs;

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
    
    Get.showSnackbar(GetSnackBar(message: generalResponse.msg,duration: const Duration(seconds:3 ),));
    
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
}