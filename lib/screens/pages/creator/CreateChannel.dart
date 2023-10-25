import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class CreateChannel extends StatefulWidget {
  @override
  _CreateChannelState createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  TextEditingController _channelNameController = TextEditingController();
  TextEditingController _channelPriceController = TextEditingController();
   final ImagePickerController controller = Get.put(ImagePickerController());
  bool _isChannelPaid = false;
  File? _channelImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _channelImage = File(pickedFile.path);
      });
    }
  }

  void _createChannel() {
    // Implement channel creation logic here
    String channelName = _channelNameController.text;
    String channelPrice = _channelPriceController.text;

    if (_channelImage == null) {
      // Show an error message indicating that an image is required.
      return;
    }

    // Continue with channel creation and validation logic.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Channel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Channel Name"),
            TextFormField(
              controller: _channelNameController,
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
                  : Icon(Icons.camera_alt, size: 100, color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.pickImage();
              },
              child: Text("Pick an Image"),
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
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createChannel,
              child: const Text("Create Channel"),
            ),
          ],
        ),
      ),
    );
  }
}
class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }
}