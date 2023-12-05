import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:async';
import 'package:educationadmin/widgets/ProgressIndicatorWidget.dart';
import 'package:get/get.dart';

import 'package:pod_player/pod_player.dart';
import 'package:educationadmin/Modals/VideoResourcesModal.dart';
import 'package:educationadmin/screens/common/ChatView.dart';
import 'package:flutter/material.dart';

// import 'package:pod_player/pod_player.dart';
class PodYouTubePlayerScreen extends StatefulWidget {
  const PodYouTubePlayerScreen({super.key, required this.video});
  final Videos video;
  @override
  PodYouTubePlayerScreenState createState() => PodYouTubePlayerScreenState();
}

class PodYouTubePlayerScreenState extends State<PodYouTubePlayerScreen> {

  late final PodPlayerController controller;
  @override
  void initState() {

     controller = PodPlayerController(
    playVideoFrom: PlayVideoFrom.youtube(widget.video.link!,live: widget.video.isLive??false,videoPlayerOptions: VideoPlayerOptions()),
    podPlayerConfig: const PodPlayerConfig(
      autoPlay: true,
      isLooping: false,
      videoQualityPriority: [1080,720, 480,360]
    ),
    
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

// class PodYouTubePlayerScreenState extends State<PodYouTubePlayerScreen> {
//   late final ChewieController chewieController;
//   late Future<bool> isPlayerInitialised;
//   @override
//   void initState() {
//     super.initState();

//     // final videoPlayerController = VideoPlayerController.network(widget.video.link!);
//     // chewieController = ChewieController(
//     //   videoPlayerController: videoPlayerController,
//     //   aspectRatio: 16 / 9, // Adjust the aspect ratio based on your video content
//     //   autoPlay: true,
//     //   looping: false,
//     //   // Add more configurations as needed
//     // );
//     isPlayerInitialised = initialisePlayer();
//   }

//   Future<bool> initialisePlayer() async {
//     final videoPlayerController =
//         VideoPlayerController.networkUrl(Uri.parse(widget.video.link!));

//     await videoPlayerController.initialize();

//     final chewieController = ChewieController(
//       isLive: widget.video.isLive!,
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('${widget.video.title}'),
//         ),
//         body: FutureBuilder(
//             future: isPlayerInitialised,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Chewie(controller: chewieController),
//                     if (widget.video.isLive != null && widget.video.isLive!)
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 4.0),
//                           child: ChatView(video: widget.video),
//                         ),
//                       ),
//                   ],
//                 );
//               } else {
//                 return SizedBox(
//                   height: Get.height,
//                   child: const ProgressIndicatorWidget(),
//                 );
//               }
//             }),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     chewieController.dispose();
//     super.dispose();
//   }
// }
