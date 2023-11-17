import 'package:educationadmin/Modals/BannersUploadResponse.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/NetworkChecker.dart';
class BannerController extends GetxController
{
  NetworkService networkService=Get.put(NetworkService());
  RxString imagePath=''.obs;
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
    }
  }
  Future<void> uploadBannerImage() async{

    NetworkChecker networkChecker=NetworkChecker();
   bool isConnectionAvailible=await networkChecker.checkConnectivity();
   if(!isConnectionAvailible)
   {
    Get.showSnackbar(const GetSnackBar(message: 'Internet Connection Unvailable',duration: Duration(seconds: 3),));

   }
   else
   {
    AuthenticationManager authenticationManager=AuthenticationManager();
    String? token=await authenticationManager.getToken();
    BannersUploadResponse imageUploadResponse=await networkService.uploadBannerImage(token: token!, file: XFile(imagePath.value));
    if(imageUploadResponse.data!=null)
    {
      Get.showSnackbar(const GetSnackBar(message: 'Image uploaded successfully',duration: Duration(seconds: 3),));
      //image.value=imageUploadResponse.data!.url!;
    }
    else
    {
      Get.showSnackbar(const GetSnackBar(message: 'Image could not be uploaded',duration: Duration(seconds: 3),));
    }
   }
  }
}