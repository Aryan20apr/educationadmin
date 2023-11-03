
import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/core/NetworkChecker.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:get/get.dart';

class ExploreViewModal extends GetxController{

  final AuthenticationManager _authmanager = Get.find<AuthenticationManager>();
  final NetworkService networkService=Get.find<NetworkService>();
final Rx<Data> channelData=Data().obs;

  Future<bool> getChannels() async
  {
    NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      return false;
    }
    String? token=await _authmanager.getToken();
    if(token!=null)
    {
     ChannelListModal channelListModal=await   networkService.getAllChannelList(token: token);
     if(channelListModal.data!=null) {
       channelData.value=channelListModal.data!;
       return true;
     }
     else
     {
      return false;
     }
    }
    return false;
  }
}