import 'dart:io';

import 'package:educationadmin/screens/pages/creator/CreateChannel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../Modals/ChannelListModal.dart';
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
                          //_isChannelPaid = value;
                          //_channelPriceController.clear(); // Clear the price when changing the switch.
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
                const SizedBox(height: 16),
                Obx(
                  ()=> controller.isLoading.value==false? ElevatedButton(
                  
                    onPressed: _createChannel,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Update Channel"),
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