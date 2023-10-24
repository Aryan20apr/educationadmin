
import 'package:educationadmin/Modals/SignupResponseModal.dart';
import 'package:educationadmin/utils/core/cache_manager.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  final username="".obs;
  final phone="".obs;
  final email="".obs;
  final password="".obs;
  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(Data data) async {
    isLogged.value = true;
   // username.value = signupModal.name!;
    //Token is cached
    await saveToken(data.token);
  }

  Future<void> checkLoginStatus() async{
    final String? token = await getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}