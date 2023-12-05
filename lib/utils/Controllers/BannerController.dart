import 'package:talentsearchenglish/Modals/BannersUploadResponse.dart';
import 'package:talentsearchenglish/Modals/ProfileUpdateResponse.dart';
import 'package:talentsearchenglish/utils/Controllers/AuthenticationController.dart';
import 'package:talentsearchenglish/utils/service/NetworkService.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Modals/BannersResponse.dart' as banners;
import '../core/NetworkChecker.dart';

class BannerController extends GetxController {
  NetworkService networkService = Get.put(NetworkService());
  AuthenticationManager authenticationManager = AuthenticationManager();
  RxString imagePath = ''.obs;
  RxBool isLoading = false.obs;
  Rx<banners.Data> bannersList = banners.Data().obs;
  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
    }
  }

  Future<void> uploadBannerImage() async {
    isLoading.value = true;
    NetworkChecker networkChecker = NetworkChecker();
    bool isConnectionAvailible = await networkChecker.checkConnectivity();
    if (!isConnectionAvailible) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Internet Connection Unvailable',
        duration: Duration(seconds: 3),
      ));
    } else {
      String? token = await authenticationManager.getToken();
      BannersUploadResponse imageUploadResponse = await networkService
          .uploadBannerImage(token: token!, file: XFile(imagePath.value));
      isLoading.value = false;
      if (imageUploadResponse.data != null) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Image uploaded successfully',
          duration: Duration(seconds: 3),
        ));
        //image.value=imageUploadResponse.data!.url!;
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: 'Image could not be uploaded',
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  Future<bool> getBanners() async {
    NetworkChecker networkChecker = NetworkChecker();
    bool check = await networkChecker.checkConnectivity();
    if (check == false) {
      return false;
    }
    String? token = await authenticationManager.getToken();
    if (token != null) {
      banners.BannersResponse bannersListModal =
          await networkService.getBanners(jwt: token);
      if (bannersListModal.data != null) {
        bannersList.value = bannersListModal.data!;
        return true;
      }
    }
    return false;
  }

  Future<void> deleteBanner({required int id, required int index}) async {
    NetworkChecker networkChecker = NetworkChecker();

    bool check = await networkChecker.checkConnectivity();
    if (check == false) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Could not delete banner, check connectivity',
        duration: Duration(seconds: 3),
      ));
      return;
    }
    String? token = await authenticationManager.getToken();
    if (token != null) {
      GeneralResponse2 response =
          await networkService.deleteBanner(id: id, token: token);
      if (response.data != null && response.data!.status!) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Banner deleted successfully',
          duration: Duration(seconds: 3),
        ));
        bannersList.value.banners!.removeAt(index);
        bannersList.refresh();
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: 'Banner could not be deleted.',
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: 'Banner could not be deleted',
        duration: Duration(seconds: 3),
      ));
    }
  }
}
