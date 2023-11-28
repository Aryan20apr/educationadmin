
import 'dart:io';

import 'package:educationadmin/Modals/ChannelCreationResponse.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/Controllers/BannerController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../widgets/ProgressIndicatorWidget.dart';
import 'ImagePickerController.dart';
class UploadBanner extends StatefulWidget {
  const UploadBanner({super.key});

  @override
  UploadBannerState createState() => UploadBannerState();
}

class UploadBannerState extends State<UploadBanner> {
  
  final BannerController controller = Get.put(BannerController());


  
  final Logger logger=Logger();
 

  void _uploadImage() {
    
      if (controller.imagePath.value.isEmpty) {
        Get.showSnackbar(const GetSnackBar(
          
          message: 'Image cannot be empty',
          duration: Duration(seconds: 3),
        ));
        
      }
      else
      {
        controller.uploadBannerImage();
      }

      // Continue with channel creation and validation logic.
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Upload Banner",style:TextStyle(
          fontSize: 14.sp,fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             
               //SizedBox(height: Get.height*0.05),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8.0),
                 child: Container(
                  decoration: BoxDecoration(
                  color: Colors.greenAccent.shade100,
                 borderRadius: const BorderRadius.all(Radius.circular(20))
                               ),
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Column(
                       children: [
                         Text("Banner Image",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                   Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => controller.imagePath.isNotEmpty
                                    ? Image.file(
                                        File(controller.imagePath.value),
                                        width: Get.height*0.2,
                                        height: Get.width*0.8,
                                      )
                                    : Icon(Icons.camera_alt, size: Get.height*0.15, color: CustomColors.secondaryColor),
                              ),
                               SizedBox(height: Get.height*0.02),
                              ElevatedButton(
                                 style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),
                                onPressed: () {
                                  controller.pickImage();
                                },
                                child:const  Text("Pick an Image"),
                              ),
                            ],
                          ),
                                   ),
                       ],
                     ),
                   ),
                 ),
               ),
               //SizedBox(height: Get.height*0.05),
              
               //SizedBox(height: Get.height*0.1),
              Obx(
                ()=> controller.isLoading.value==false? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:16.0),
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: Size(Get.width*0.7, Get.height*0.07),shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),
                      onPressed: _uploadImage,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Upload Banner"),
                      ),
                    ),
                  ),
                ):Center(
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(fixedSize: Size(Get.width*0.7, Get.height*0.07),shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),
                    onPressed: (){},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ProgressIndicatorWidget(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
