
import 'dart:io';

import 'package:educationadmin/Modals/ChannelCreationResponse.dart';
import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../widgets/ProgressIndicatorWidget.dart';
import 'ImagePickerController.dart';
class CreateChannel extends StatefulWidget {
  const CreateChannel({super.key});

  @override
  CreateChannelState createState() => CreateChannelState();
}

class CreateChannelState extends State<CreateChannel> {
  final TextEditingController _channelNameController = TextEditingController();
  final TextEditingController _channelPriceController = TextEditingController();
  final ImagePickerController controller = Get.put(ImagePickerController());
  bool _isChannelPaid = false;

  final _formKey = GlobalKey<FormState>(); // Create a form key
  final Logger logger=Logger();
 

  void _createChannel() {
    if (_formKey.currentState!.validate()) {
      // Implement channel creation logic here
      controller.channelName.value = _channelNameController.text;
      controller.channelPrice.value = int.parse(_channelPriceController.text.isEmpty?"0":_channelPriceController.text);
      controller.isChannelPaid.value=_isChannelPaid;
      logger.e("Is channel paid: $_isChannelPaid");
      logger.e("Image is blank ${controller.imagePath}");
      if (controller.imagePath.value.isEmpty) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.green,
          message: 'Image cannot be empty',
          duration: Duration(seconds: 3),
        ));
        
      }
      else
      {
        controller.createChannel();
      }

      // Continue with channel creation and validation logic.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title:  Text("Create Channel",style:TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Form(
            key: _formKey, // Associate the form key with the form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                        SizedBox(height: Get.height*0.04,),
                         Text("Channel Name",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your channel name',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 12.sp,fontWeight: FontWeight.w300)
                            ),
                            controller: _channelNameController,
                                   validator: (value) {
                              final alphanumeric = RegExp(r'^[a-zA-Z0-9\s]+$');
                              if (value!.isEmpty) {
                                return 'Channel name is required';
                              }
                              if (!alphanumeric.hasMatch(value)) {
                                return 'Channel name must be alphanumeric';
                              }
                              return null;
                            },
                         
                          ),
                       ],
                     ),
                   ),
                 ),
               ),
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
                           Text("Thumbnail Image",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                     Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => controller.imagePath.isNotEmpty
                                      ? Image.file(
                                          File(controller.imagePath.value),
                                         width: double.infinity,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                   borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Row(
                              children: <Widget>[
                                 Text("Is Channel Paid?",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                Switch(
                                  activeColor: CustomColors.primaryColorDark,
                                  
                                  inactiveThumbColor: Colors.grey.shade600,
                                  inactiveTrackColor: Colors.grey.shade400,
                                  value: _isChannelPaid,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChannelPaid = value;
                                      _channelPriceController.clear(); // Clear the price when changing the switch.
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          _isChannelPaid? SizedBox(height: Get.height*0.04):const SizedBox(height: 0.0,),
                          _isChannelPaid
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                     Text("Price (in ₹)",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      
                            decoration: InputDecoration(
                              hintText: 'Enter your channel price',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 12.sp,fontWeight: FontWeight.w300)
                            ),
                                      controller: _channelPriceController,
                                       validator: (value) {
                                        final digitOnly = RegExp(r'^\d+$');
                                        if (_isChannelPaid && value!.isEmpty) {
                                          return 'Price is required for paid channels';
                                        }
                                        if (_isChannelPaid && !digitOnly.hasMatch(value!)) {
                                          return 'Price must be a digit';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Get.height*0.08,)
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                 //SizedBox(height: Get.height*0.1),
                Obx(
                  ()=> controller.isLoading.value==false? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:16.0),
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(minimumSize: Size(Get.width*0.7, Get.height*0.05),shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),
                        onPressed: _createChannel,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Create Channel"),
                        ),
                      ),
                    ),
                  ):Center(
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(minimumSize: Size(Get.width*0.7, Get.height*0.05),shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),
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
      ),
    );
  }
}
