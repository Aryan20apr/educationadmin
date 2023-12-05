import 'dart:developer';
import 'package:talentsearchenglish/Modals/ProfileUpdateResponse.dart';
import 'package:talentsearchenglish/Modals/SingnupModal.dart';
import 'package:logger/logger.dart';

import 'package:talentsearchenglish/Modals/ImageUploadResponse.dart';
import 'package:talentsearchenglish/Modals/UserModal.dart';
import 'package:talentsearchenglish/utils/Controllers/AuthenticationController.dart';
import 'package:talentsearchenglish/utils/core/NetworkChecker.dart';
import 'package:talentsearchenglish/utils/core/cache_manager.dart';
import 'package:talentsearchenglish/utils/service/NetworkService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsManager extends GetxController with CacheManager {
  Logger logger = Logger();
  final isInitialised = false.obs;
  final id = 0.obs;
  final createdAt = "".obs;
  final updatedAt = "".obs;
  final username = "".obs;
  final phone = "".obs;
  final email = "".obs;
  final image = "".obs;
  final RxString imagePath = ''.obs;
  RxBool isUpdating = false.obs;

  NetworkService networkService = NetworkService();
  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
    }
  }

  Future<void> updateProfile(
      {required String email, required String username}) async {
    isUpdating.value = true;
    logger.e('Image path: ${imagePath.value}');
    NetworkChecker networkChecker = NetworkChecker();
    var status = await networkChecker.checkConnectivity();
    AuthenticationManager authenticationManager = AuthenticationManager();
    String? token = await authenticationManager.getToken();

    if (status == false) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Internet Connection Unvailable',
        duration: Duration(seconds: 3),
      ));
    } else {
      ImageUploadResponse? imageUploadResponse;
      if (imagePath.isEmpty == false) {
        imageUploadResponse = await networkService.uploadProfileImage(
            token: token!, file: XFile(imagePath.value));

        if (imageUploadResponse.data != null) {
          image.value = imageUploadResponse.data!.url!;
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: 'Could not update profile picture',
            duration: Duration(seconds: 3),
          ));
        }
      }

      SignupModal signupModal =
          SignupModal(name: username, phone: phone.value, email: email);
      GeneralResponse2 response = await networkService.updateProfile(
          signupModal: signupModal, token: token!, image: image.value);
      isUpdating.value = false;

      if (response.data == null) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Could not update profile',
          duration: Duration(seconds: 3),
        ));
      } else {
        if (response.data!.status!) {
          Get.showSnackbar(const GetSnackBar(
            message: 'Profile details updated ',
            duration: Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: 'Profile could not be updated. ',
            duration: Duration(seconds: 3),
          ));
        }
      }
    }
    //   NetworkChecker networkChecker=NetworkChecker();
    //  bool isConnectionAvailible=await networkChecker.checkConnectivity();
    //  if(!isConnectionAvailible)
    //  {
    //   Get.showSnackbar(const GetSnackBar(message: 'Internet Connection Unvailable',duration: Duration(seconds: 3),));

    //  }
    //  else
    //  {
    //   AuthenticationManager authenticationManager=AuthenticationManager();
    //   String? token=await authenticationManager.getToken();
    //   ImageUploadResponse imageUploadResponse=await networkService.uploadProfileImage(token: token!, file: XFile(imagePath.value));
    //   if(imageUploadResponse.data!=null)
    //   {
    //     Get.showSnackbar(const GetSnackBar(message: 'Image uploaded successfully',duration: Duration(seconds: 3),));
    //     image.value=imageUploadResponse.data!.url!;
    //   }
    //   else
    //   {
    //     Get.showSnackbar(const GetSnackBar(message: 'Image could not be uploaded',duration: Duration(seconds: 3),));
    //   }
    //}
  }

  void initializeUserDetails({required UserModal userModal}) async {
    id.value = userModal.consumer!.id!;
    createdAt.value = userModal.consumer!.createdAt!;
    updatedAt.value = userModal.consumer!.updatedAt!;
    username.value = userModal.consumer!.name!;
    phone.value = userModal.consumer!.phone!;
    email.value = userModal.consumer!.email!;
    image.value = userModal.consumer!.image ?? "";
    final storage = new FlutterSecureStorage();
    // Write value
    await storage.write(key: "id", value: '${id.value}');
    await storage.write(key: "createdAt", value: createdAt.value);
    await storage.write(key: "updatedAt", value: updatedAt.value);
    await storage.write(key: "username", value: username.value);
    await storage.write(key: "phone", value: phone.value);
    await storage.write(key: "email", value: email.value);
    await storage.write(key: "image", value: image.value);

    //image.value=userModal.consumer!.image!;
    isInitialised.value = true;
    log("User initialised");
  }

  Future<void> initializeFromStorage() async {
    final storage = new FlutterSecureStorage();
    String? id1 = await storage.read(key: "id");
    id.value = int.parse(id1!);
    createdAt.value = await storage.read(key: "createdAt") ?? "";
    updatedAt.value = await storage.read(key: "updatedAt") ?? "";
    username.value = await storage.read(key: "username") ?? "";
    phone.value = await storage.read(key: "phone") ?? "";
    email.value = await storage.read(key: "email") ?? "";
    image.value = await storage.read(key: "image") ?? "";

    //image.value=userModal.consumer!.image!;
    isInitialised.value = true;
    log("User initialised");
  }
  // void logOut() {
  //   isLogged.value = false;
  //   removeToken();
  // }

  // void login(Data data) async {
  //   isLogged.value = true;
  //  // username.value = signupModal.name!;
  //   //Token is cached
  //   await saveToken(data.token);
  // }

  // void checkLoginStatus() async{
  //   final String? token = await getToken();
  //   if (token != null) {
  //     isLogged.value = true;
  //   }
  // }
}
