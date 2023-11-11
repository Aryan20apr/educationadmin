import 'dart:io';

import 'package:educationadmin/screens/pages/creator/CreateChannel.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../Modals/ChannelListModal.dart';
import 'ImagePickerController.dart';
class EditChannel extends StatefulWidget {
 const EditChannel({super.key,required this.channel});
 final Channels channel;
  @override
  EditChannelState createState() => EditChannelState();
}

class EditChannelState extends State<EditChannel> {
  final TextEditingController _channelNameController = TextEditingController();
  final TextEditingController _channelPriceController = TextEditingController();
  final ImagePickerController controller = Get.put(ImagePickerController());
  bool _isChannelPaid = false;

  final _formKey = GlobalKey<FormState>(); // Create a form key
  final Logger logger=Logger();
 
  @override
  void initState(){
    _channelNameController.text=widget.channel.name!;
    _channelPriceController.text=(widget.channel.price!).toString();
    _isChannelPaid=widget.channel.isCompletelyPaid!;
    Logger().e("Channel paid ? ${_isChannelPaid} ${widget.channel.isCompletelyPaid!}");
    super.initState();
  }

  void _createChannel() {
    if (_formKey.currentState!.validate()) {
      // Implement channel creation logic here
      controller.channelName.value = _channelNameController.text;
      controller.channelPrice.value = int.parse(_channelPriceController.text);
      controller.isChannelPaid.value=_isChannelPaid;
      logger.e("Image is blank ${controller.imagePath}");
   
     
        controller.updateChannel(widget.channel.id!);
      

      // Continue with channel creation and validation logic.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Channel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Associate the form key with the form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                         SizedBox(height: Get.height*0.04,),
                        Text("Channel Name",style:TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold),),
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                 Container(
                   decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius:const BorderRadius.all(Radius.circular(20))),
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
                                        width: 200,
                                        height: 200,
                                      )
                                    : const Icon(Icons.camera_alt, size: 100, color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                                     style: ElevatedButton.styleFrom(minimumSize: Size(Get.width*0.4, Get.height*0.05),shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),

                                onPressed: () {
                                  controller.pickImage();
                                },
                                child: const Text("Pick an Image"),
                              ),
                            ],
                          ),
                                   ),
                       ],
                     ),
                   ),
                 ),
                const SizedBox(height: 16),
                Container(
                   decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                             Text("Is Channel Paid?",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold)),
                            _isChannelPaid?Icon(Icons.check_circle_outline_rounded,color: ColorConstants.accentColor,):Icon(Icons.close_outlined)
                          ],
                        ),
                        _isChannelPaid
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                   Text("Price (in Rupees)",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                  TextFormField(
                                    enabled: false,
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  ()=> controller.isLoading.value==false? Center(
                    child: ElevatedButton(
                     style: ElevatedButton.styleFrom(minimumSize: Size(Get.width*0.8, Get.height*0.05),shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: CustomColors.primaryColor,foregroundColor: CustomColors.primaryColorDark),
                      onPressed: _createChannel,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Update Channel"),
                      ),
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