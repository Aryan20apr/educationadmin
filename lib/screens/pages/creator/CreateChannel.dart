
import 'dart:io';

import 'package:educationadmin/Modals/ChannelCreationResponse.dart';
import 'package:educationadmin/utils/Controllers/AuthenticationController.dart';
import 'package:educationadmin/utils/service/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
class CreateChannel extends StatefulWidget {
  @override
  _CreateChannelState createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  TextEditingController _channelNameController = TextEditingController();
  TextEditingController _channelPriceController = TextEditingController();
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
        title: const Text("Create Channel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Associate the form key with the form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Channel Name"),
                TextFormField(
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
                const SizedBox(height: 16),
                const Text("Thumbnail Image"),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => controller.imagePath.isNotEmpty
                            ? Image.file(
                                File(controller.imagePath.value),
                                width: 200,
                                height: 200,
                              )
                            : const Icon(Icons.camera_alt, size: 100, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          controller.pickImage();
                        },
                        child: const Text("Pick an Image"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Text("Is Channel Paid?"),
                    Switch(
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
                _isChannelPaid
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Price (in Rupees)"),
                          TextFormField(
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
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 16),
                Obx(
                  ()=> controller.isLoading.value==false? ElevatedButton(
                  
                    onPressed: _createChannel,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Create Channel"),
                    ),
                  ):ElevatedButton(
                    
                    onPressed: (){},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
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

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;
  RxString channelName="".obs;
  RxInt channelPrice=0.obs;
  RxBool isChannelPaid=false.obs;
  RxBool isLoading=false.obs;
  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
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
     Logger().e("Is channel completely paid ${isChannelPaid}");
    CreateChannelResponseModal modal=await networkService.editChannel(token:token,file:imagePath.value.isNotEmpty? XFile(imagePath.value):null,  name: channelName.value, channelid: channelId);
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