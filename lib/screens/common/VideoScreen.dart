// import 'dart:convert';
// import 'dart:developer';


// import 'package:educationadmin/Modals/VideoResourcesModal.dart';
// import 'package:educationadmin/screens/common/ChatView.dart';
// import 'package:flutter/material.dart';


// class YouTubePlayerScreen extends StatefulWidget {

//  const YouTubePlayerScreen({super.key,required this.video});
//  final Videos video ;
//   @override
//   YouTubePlayerScreenState createState() => YouTubePlayerScreenState();

// }

// class YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
//   late YoutubePlayerController _controller;
//   late YoutubePlayerFlags _flags;
//   String _videoLink = ''; // Store the fetched video link

//   @override
//   void initState() {
//     super.initState();
//     // Set flags for the YouTube player (e.g., captions)
//     _flags = const YoutubePlayerFlags(
//       autoPlay: true,
//       mute: false,
//       captionLanguage: 'en', // Replace with your desired caption language code
//     );

    

//      _videoLink = widget.video.link!;
//         // Update the controller with the fetched video link
//         _controller = YoutubePlayerController(
//           initialVideoId: YoutubePlayer.convertUrlToId(_videoLink)!,
//           flags: _flags,
//         );
   
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
      
//       child: YoutubePlayerBuilder(
//         onExitFullScreen: (){
//           log('Full Screen');
          
//         },
//         onEnterFullScreen: (){
//          // _controller.toggleFullScreenMode();
//         },
//         player:YoutubePlayer(
//                     controller: _controller,
//                     showVideoProgressIndicator: true,
//                     onReady: () {
//                       // Video is ready to play
//                     },
//                     onEnded: (data) {
//                       // Video has ended
//                     },
//                   ),
//         builder: (context,player) {
//           return Scaffold(
            
//             appBar: AppBar(
//               title: Text('${widget.video.title}'),
//             ),
//             body:Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
//               //  _videoLink.isNotEmpty
//               // ? SizedBox(
//               //   width: MediaQuery.of(context).size.width,
    
//               //   child: 
                
//             player,
            
//             if(widget.video.isLive!=null && widget.video.isLive!)
//               Expanded(child: Padding(
//                 padding: const EdgeInsets.only(top:4.0),
//                 child: ChatView(video: widget.video,),
//               ))
//             ])
//           );
//         }
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// // import 'dart:convert';
// // import 'dart:developer';


// // import 'package:educationadmin/Modals/VideoResourcesModal.dart';
// // import 'package:educationadmin/screens/common/ChatView.dart';
// // import 'package:flutter/material.dart';
// // import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// // class YouTubePlayerScreen extends StatefulWidget {

// //  const YouTubePlayerScreen({super.key,required this.video});
// //  final Videos video ;
// //   @override
// //   YouTubePlayerScreenState createState() => YouTubePlayerScreenState();

// // }

// // class YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
// //   late YoutubePlayerController _controller;
// //   //late YoutubePlayerFlags _flags;
// //   //String _videoLink = ''; // Store the fetched video link

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Set flags for the YouTube player (e.g., captions)
// //     // _flags = const YoutubePlayerFlags(
// //     //   autoPlay: true,
// //     //   mute: false,
// //     //   captionLanguage: 'en', // Replace with your desired caption language code
// //     // );
// //     _controller=YoutubePlayerController(
// //        params: const YoutubePlayerParams(
// //         enableJavaScript: false,
// //         captionLanguage: 'en',
// //         strictRelatedVideos: true,
// //         showControls: true,
// //         mute: false,
// //         showFullscreenButton: true,
// //         loop: false,
        
// //       ),
// //     );

    

// //     //  _videoLink = widget.video.link!;
// //     //     // Update the controller with the fetched video link
// //     //     _controller = YoutubePlayerController(
// //     //       initialVideoId: YoutubePlayer.convertUrlToId(_videoLink)!,
// //     //       flags: _flags,
// //     //     );

// //          _controller.setFullScreenListener(
// //       (isFullScreen) {
// //         log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
// //       },
// //     );

// //     _controller.loadVideoByUrl( mediaContentUrl:widget.video.link! );
   
// //   }

  

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
      
// //       child: YoutubePlayerScaffold(
// //         controller: _controller,
// //         aspectRatio: 16 / 9,
// //         // onExitFullScreen: (){
// //         //   log('Full Screen');
// //         //   _controller.toggleFullScreenMode();
// //         // },
// //         // onEnterFullScreen: (){
// //         //  // _controller.toggleFullScreenMode();
// //         // },
// //         // player:YoutubePlayer(
// //         //             controller: _controller,
// //         //             showVideoProgressIndicator: true,
// //         //             onReady: () {
// //         //               // Video is ready to play
// //         //             },
// //         //             onEnded: (data) {
// //         //               // Video has ended
// //         //             },
// //         //           ),
// //         builder: (context,player) {
// //           return Scaffold(
            
// //             appBar: AppBar(
// //               title: Text('${widget.video.title}'),
// //             ),
// //             body:Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
// //               //  _videoLink.isNotEmpty
// //               // ? SizedBox(
// //               //   width: MediaQuery.of(context).size.width,
    
// //               //   child: 
                
// //             player,
            
// //             if(widget.video.isLive!=null && widget.video.isLive!)
// //               Expanded(child: Padding(
// //                 padding: const EdgeInsets.only(top:4.0),
// //                 child: ChatView(video: widget.video,),
// //               ))
// //             ])
// //           );
// //         }
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.stopVideo();
// //     _controller.close();
    
// //     super.dispose();
// //   }
// // }
