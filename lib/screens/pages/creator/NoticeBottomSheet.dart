import 'package:educationadmin/screens/pages/Explore2.dart';
import 'package:educationadmin/utils/ColorConstants.dart';
import 'package:educationadmin/utils/Controllers/NoticesController.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
class NoticeBottomSheet{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  NoticesController noticesController=Get.put(NoticesController());
  void showCreateNoticeBottomSheet({required BuildContext context,required int channeId}) {
    showModalBottomSheet(
      backgroundColor: CustomColors.secondaryColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height*0.45,
          padding:const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context,constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'New Notice',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: constraints.maxHeight*0.05),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxHeight*0.05),
                    TextFormField(
                      maxLines: 3,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxHeight*0.05),
                    Center(
                      child: Obx(
                        ()=>noticesController.isLoading.value?ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: Size(constraints.maxWidth*0.4, constraints.maxHeight*0.1),backgroundColor: CustomColors.primaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                      
                                noticesController.createNotice(title: titleController.text, description: descriptionController.text, channelId: channeId);
                              
                            }
                          },
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(height:constraints.maxHeight*0.05,width: constraints.maxHeight*0.05,child: const Center(child: CircularProgressIndicator(strokeWidth: 4.0,backgroundColor: CustomColors.primaryColorDark,)))
                          ),
                        ): ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: Size(constraints.maxWidth*0.4, constraints.maxHeight*0.1),backgroundColor: CustomColors.primaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                      
                                noticesController.createNotice(title: titleController.text, description: descriptionController.text, channelId: channeId);
                              
                            }
                          },
                          child:  Padding(
                            padding:const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Create Notice',
                              style: TextStyle(fontSize: 10.sp,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        );
      },
    );
  }
}