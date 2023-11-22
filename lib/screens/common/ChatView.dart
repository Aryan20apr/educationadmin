import 'package:educationadmin/utils/Controllers/ChatController.dart';
import 'package:educationadmin/utils/Controllers/UserController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Modals/VideoResourcesModal.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key,required this.video});
  final Videos video;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

late TextEditingController _messageInputController;
ChatController chatController=Get.put(ChatController());
UserDetailsManager userDetailsManager=Get.put(UserDetailsManager());
ScrollController scrollController=ScrollController();
  @override
  void initState()
  {

    super.initState();
    _messageInputController=TextEditingController();
    chatController.initialiseSocket();
    chatController.joinRoom(id: widget.video.id!);

    chatController.chatList.listen((chatList) {
    if (mounted) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const
 
Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });
  }
  @override
  void dispose()
  {
     chatController.leaveRoom(id: widget.video.id!,);
     _messageInputController.dispose();
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              ()=>Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  dragStartBehavior:DragStartBehavior.down,reverse: false,physics:const BouncingScrollPhysics(),itemBuilder: (context,index){
                
                      return Wrap(
                        alignment: chatController.chatList[index].userName == userDetailsManager.username.value
                            ? WrapAlignment.end
                            : WrapAlignment.start,
                        children: [
                          Card(
                            color: chatController.chatList[index].userName == userDetailsManager.username.value
                                ? Colors.lightGreenAccent.shade200
                                : Colors.yellowAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                    chatController.chatList[index].userName == userDetailsManager.username.value
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Text(chatController.chatList[index].message!,style: TextStyle(fontSize: 12.sp,color: Colors.black)),
                                  Text(chatController.chatList[index].userName!,style: TextStyle(fontSize: 10.sp,color: Colors.grey),)
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                     
                }, separatorBuilder: (_, index) =>  SizedBox(
                      height: 0.05.h,
                    ), itemCount: chatController.chatList.length),
              )
            ),
            //SizedBox(height: constraints.maxHeight*0.1,),
            Container(
              height: constraints.maxHeight*0.1,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // scrollController.animateTo(
                      //   scrollController.position.maxScrollExtent,
                      //   duration: const Duration(milliseconds: 300),
                      //   curve: Curves.easeOut,
                      // );
                      if (_messageInputController.text.trim().isNotEmpty) {
                        chatController.sendMessage(id: widget.video.id!, message: _messageInputController.text);
                        _messageInputController.clear();
                         
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        );
      }
    );
  }
}