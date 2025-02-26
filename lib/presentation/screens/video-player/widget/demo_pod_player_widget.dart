// import 'dart:async';
// import 'dart:convert';
// import 'package:demo_course_video/core/utils/colors.dart';
// import 'package:demo_course_video/core/utils/dimens.dart';
// import 'package:flutter/material.dart';
// import 'package:pod_player/pod_player.dart';
// import 'package:http/http.dart' as http;

// class PlayerWidget extends StatefulWidget {
//   const PlayerWidget({super.key});

//   @override
//   State<PlayerWidget> createState() => _PlayerWidgetState();
// }

// class _PlayerWidgetState extends State<PlayerWidget> {
//   late final PodPlayerController controller;
//   List<CaptionData> captions = [];
//   String currentCaption = '';
//   Timer? captionTimer;

//   @override
//   void initState() {
//     super.initState();

//     String videoId = '1048565727';
//     String token = 'e774c9a7cb029312b177771529753a7a';
//     final Map<String, String> headers = <String, String>{
//       'Authorization': 'Bearer $token',
//     };

//     // Initialize PodPlayerController
//     controller = PodPlayerController(
//       playVideoFrom: PlayVideoFrom.vimeoPrivateVideos(
//         videoId,
//         httpHeaders: headers,
//       ),
//     )..initialise();

//     // Fetch and parse captions
//     _loadCaptions();

//     // Start caption update listener
//     startCaptionTimer();
//   }

//   startCaptionTimer(){
//     captionTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
//       _updateCaption();
//     });
//     setState(() {
      
//     });
//   }

//   Future<void> _loadCaptions() async {
//     const captionUrl = "https://captions.cloud.vimeo.com/captions/208125062.vtt?expires=1737620151&sig=2e89866f1e2576679a927721a5cc6024a38807e6&download=auto_generated_captions.vtt";
//     final response = await http.get(Uri.parse(captionUrl));
//     if (response.statusCode == 200) {
//       setState(() {
//         captions = _parseVtt(response.body);
//       });
//     } else {
//       debugPrint('Failed to load captions: ${response.statusCode}');
//     }
//   }

//   List<CaptionData> _parseVtt(String vttContent) {
//     final List<CaptionData> captionList = [];
//     final lines = LineSplitter.split(vttContent).toList();
//     for (int i = 0; i < lines.length; i++) {
//       if (lines[i].contains('-->')) {
//         final times = lines[i].split(' --> ');
//         final text = lines[i + 1];
//         captionList.add(CaptionData(
//           startTime: _parseDuration(times[0]),
//           endTime: _parseDuration(times[1]),
//           text: text,
//         ));
//       }
//     }
//     return captionList;
//   }

//   Duration _parseDuration(String time) {
//     final parts = time.split(':');
//     return Duration(
//       hours: int.parse(parts[0]),
//       minutes: int.parse(parts[1]),
//       seconds: int.parse(parts[2].split('.')[0]),
//       milliseconds: int.parse(parts[2].split('.')[1]),
//     );
//   }

//   void _updateCaption() {
//     if (captions.isNotEmpty && controller.isInitialised) {
//       final currentPosition = controller.currentVideoPosition;
//       final caption = captions.firstWhere(
//         (caption) =>
//             currentPosition >= caption.startTime &&
//             currentPosition <= caption.endTime,
//         orElse: () => CaptionData.empty(),
//       );
//       if (currentCaption != caption.text) {
//         setState(() {
//           currentCaption = caption.text;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: DeviceDimens.width,
//       color: AppColor.black,
//       child: AspectRatio(
//         aspectRatio: 16 / 9,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             PodVideoPlayer(
//               controller: controller,
//               alwaysShowProgressBar: true,
//               podProgressBarConfig: const PodProgressBarConfig(
//                 playingBarColor: AppColor.pink,
//                 circleHandlerColor: AppColor.pink,
//                 circleHandlerRadius: 6,
//               ),
//               videoThumbnail: const DecorationImage(
//                 image: NetworkImage(
//                     "https://i.vimeocdn.com/video/1908584820-13a2fa9483fe75aa1247d413bb67c9e794a016923794b73bc71c25ab0dfce78f-d"),
//               ),
//               overlayBuilder: (options) => buildOverlay(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     captionTimer?.cancel();
//     super.dispose();
//   }
  
//   Widget buildOverlay() {
//     final durationText = "${controller.currentVideoPosition.inMinutes}:${(controller.currentVideoPosition.inSeconds % 60).toString().padLeft(2, '0')}/" "${controller.totalVideoLength.inMinutes}:${(controller.totalVideoLength.inSeconds % 60).toString().padLeft(2, '0')}";

//     return Stack(
//       children: [
//         // Custom captions
//         captionTimer!.isActive ?
//         Positioned(
//           bottom: 20, 
//           left: 10,
//           right: 10,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.all(3),
//               child: Text(
//                 currentCaption,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   backgroundColor: AppColor.black
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ) : const SizedBox(),
        
//         Positioned(
//           top: 10,
//           right: 10,
//           child: IconButton(
//             onPressed: (){
//               controller.isFullScreen ? controller.disableFullScreen(context) :controller.enableFullScreen();
//             } , 
//             icon: const Icon(Icons.zoom_out_map)
//           )
//         ),

//         Positioned(
//           top: 10,
//           left: 10,
//           child: IconButton(
//             onPressed: (){
//               captionTimer!.isActive ? captionTimer!.cancel() : startCaptionTimer();
//             } , 
//             icon: const Icon(Icons.subtitles)
//           )
//         ),

//         Positioned(
//           bottom: 50, // Adjust the position for progress bar
//           left: 10,
//           right: 10,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Text(
//               durationText,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 backgroundColor: AppColor.black,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CaptionData {
//   final Duration startTime;
//   final Duration endTime;
//   final String text;

//   CaptionData({
//     required this.startTime,
//     required this.endTime,
//     required this.text,
//   });

//   CaptionData.empty()
//       : startTime = Duration.zero,
//         endTime = Duration.zero,
//         text = '';
// }
