import 'package:get/get.dart';
class ChannelOptionsController extends GetxController
{
 RxString phoneNumber = ''.obs;

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  Future<void> addSubscriber() async
  {

  }
}