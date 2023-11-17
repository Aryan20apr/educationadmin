import 'package:educationadmin/Modals/ChannelListModal.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:get/get.dart';

import '../../Modals/BannersResponse.dart' as banners;
import '../core/NetworkChecker.dart';
import '../service/NetworkService.dart';

import 'AuthenticationController.dart';
class HomeScreenController extends GetxController
{

 final AuthenticationManager _authmanager = Get.find<AuthenticationManager>();
  final NetworkService networkService=Get.find<NetworkService>();
  final UserDetailsManager userDetailsManager=Get.find<UserDetailsManager>();
final Rx<Data> channelData=Data().obs;
final Rx<Data> allChannelData=Data().obs;
final Rx<banners.Data> bannersList=banners.Data().obs;
final RxInt currentPage=0.obs;
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
     ChannelListModal channelListModal=await   networkService.getUserChannelList(userid: userDetailsManager.id.value,token: token);
     channelData.value=channelListModal.data!;

      
     if(channelListModal.data!=null)
     {
      channelData.value=channelListModal.data!;

      return true;
     }
    
    }
     return false;
  }

  Future<bool> getAllChannels() async
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
     allChannelData.value=channelListModal.data!;

     if(channelListModal.data!=null)
     {
      allChannelData.value=channelListModal.data!;
      return true;
     }
    
    }
     return false;
  }
  Future<bool> getBanners()async
  {
    NetworkChecker networkChecker=NetworkChecker();
    bool check=await networkChecker.checkConnectivity();
    if(check==false) {
      return false;
    }
    String? token=await _authmanager.getToken();
    if(token!=null)
    {
     banners.BannersResponse bannersListModal=await   networkService.getBanners(jwt: token);
     if(bannersListModal.data!=null)

{
  bannersList.value=bannersListModal.data!;
  return true;
}
     
    
    }
     return false;
  }
}