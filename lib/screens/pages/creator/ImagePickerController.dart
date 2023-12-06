import 'package:device_info_plus/device_info_plus.dart';
import 'package:educationadmin/Modals/ChannelCreationResponse.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;
  RxString channelName="".obs;
  RxInt channelPrice=0.obs;
  RxBool isChannelPaid=false.obs;
  RxBool isLoading=false.obs;
  void pickImage() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
     if ((androidInfo.version.sdkInt > 32&& await Permission.photos.request().isGranted)||(androidInfo.version.sdkInt <=32 && await Permission.storage.request().isGranted)) {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
    }
    } else {
      // Permission is not granted
      if (await Permission.storage.isPermanentlyDenied) {
        // Permission is permanently denied
        openAppSettings();
      } else {
        // Permission is denied, show rationale and request again
       
       //pickImage();
      }
  }
  }
  
  Future<void> createChannel() async{
    isLoading.value=true;
    NetworkService networkService=NetworkService();
    AuthenticationManager authmanager=Get.put(AuthenticationManager());
     String? token=await authmanager.getToken();
     Logger().e("Is channel completely paid ${isChannelPaid}");
    CreateChannelResponseModal modal=await networkService.createChannel(token:token,file: XFile(imagePath.value), isCompletelyPaid: isChannelPaid.value, name: channelName.value, price: channelPrice.value);
    if(modal.data!=null)
    {
      Get.showSnackbar(const GetSnackBar(message: 'Channel Created Successfully',duration: Duration(seconds: 3),));
    }
    else
    {
      Get.showSnackbar(const GetSnackBar(message: 'Channel Could not be created',duration: Duration(seconds: 3)));
    }
    isLoading.value=false;
  }
  Future<void> updateChannel(int channelId) async{
    isLoading.value=true;
    NetworkService networkService=NetworkService();
    AuthenticationManager authmanager=Get.put(AuthenticationManager());
     String? token=await authmanager.getToken();
     Logger().e("Is channel completely paid ${isChannelPaid.value}");
    CreateChannelResponseModal modal=await networkService.editChannel(token:token,file:imagePath.value.isNotEmpty? XFile(imagePath.value):null,  name: channelName.value, channelid: channelId,paidChannel:isChannelPaid.value,price:channelPrice.value);
    if(modal.data!=null)
    {
      Get.showSnackbar(const GetSnackBar(message: 'Channel Updated Successfully',duration: Duration(seconds: 3),));
    }
    else
    {
      Get.showSnackbar(const GetSnackBar(message: 'Channel could not be updated',duration: Duration(seconds: 3)));
    }
    isLoading.value=false;
  }
} 