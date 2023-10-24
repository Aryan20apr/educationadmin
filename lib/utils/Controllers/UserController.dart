
import 'dart:developer';


import 'package:educationadmin/Modals/UserModal.dart';
import 'package:educationadmin/utils/core/cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';



class UserDetailsManager extends GetxController with CacheManager {
  final isInitialised=false.obs;
  final id=0.obs;
  final createdAt="".obs;
   final updatedAt="".obs;
  final username="".obs;
  final phone="".obs;
  final email="".obs;
  final image="".obs;


  void initializeUserDetails({required UserModal userModal}) async
  {
    id.value=userModal.consumer!.id!;
    createdAt.value=userModal.consumer!.createdAt!;
    updatedAt.value=userModal.consumer!.updatedAt!;
    username.value=userModal.consumer!.name!;
    phone.value=userModal.consumer!.phone!;
    email.value=userModal.consumer!.email!;
    image.value=userModal.consumer!.image??"";
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
    isInitialised.value=true;
    log("User initialised");
  }
  Future<void> initializeFromStorage() async
  {
    final storage = new FlutterSecureStorage();
    String? id1=await storage.read(key: "id");
    id.value=int.parse(id1!);
    createdAt.value=await storage.read(key: "createdAt")??"";
    updatedAt.value=await storage.read(key: "updatedAt")??"";
    username.value=await storage.read(key: "username")??"";
    phone.value=await storage.read(key: "phone") ??"";
    email.value=await storage.read(key: "email") ??"";
    image.value=await storage.read(key: "image") ??"";
    
    //image.value=userModal.consumer!.image!;
    isInitialised.value=true;
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