import 'dart:convert';
import 'dart:developer';


import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/screens/common/ChatView.dart';
import 'package:flutter/material.dart';

import 'package:pod_player/pod_player.dart';
class PodYouTubePlayerScreen extends StatefulWidget {

 const PodYouTubePlayerScreen({super.key,required this.video});
 final Videos video ;
  @override
  PodYouTubePlayerScreenState createState() => PodYouTubePlayerScreenState();

}

class PodYouTubePlayerScreenState extends State<PodYouTubePlayerScreen> {
  
  
  late final PodPlayerController controller;
  @override
  void initState() {

     controller = PodPlayerController(
    playVideoFrom: PlayVideoFrom.youtube(widget.video.link!,live: widget.video.isLive??false),
    podPlayerConfig: const PodPlayerConfig(
      autoPlay: true,
      isLooping: false,
      videoQualityPriority: [720, 360]
    )
  )..initialise();
   
    super.initState();
  

    

   
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
            
            appBar: AppBar(
              title: Text('${widget.video.title}'),
            ),
            body:Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              //  _videoLink.isNotEmpty
              // ? SizedBox(
              //   width: MediaQuery.of(context).size.width,
    
              //   child: 
                
           PodVideoPlayer(controller: controller),
            
            if(widget.video.isLive!=null && widget.video.isLive!)
              Expanded(child: Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: ChatView(video: widget.video,),
              ))
            ])
          )
        
      );
    
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

