import 'dart:developer';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/data/model/course_detail_model.dart';
import 'package:demo_course_video/data/model/single_vimeo_caption_detail.dart';
import 'package:demo_course_video/data/model/single_vimeo_video_detail_model.dart';
import 'package:demo_course_video/data/model/video_progress_model.dart';
import 'package:demo_course_video/domain/controller/video/video_player_controller.dart';
import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final VideoPlayerController videoPlayerController;

  VideoPlayerCubit({required this.videoPlayerController}) : super(VideoPlayerInitial());

  final Map<dynamic, GlobalKey> itemKeys = {};
  List<dynamic> lessonsList = [];
  
  // CourseDetailModel? courseDetail ;
  int curriculumLength = 0;
  String curriculumTitle = "";
  Map<String, VideoProgressModel> videoProgressMetaData = {};
  int currentIndexPlaying = -1;
  int temp = 0;
  ScrollController playlistScrollController = ScrollController();
  
  late BetterPlayerController betterPlayerController ;
  final BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
    controlsConfiguration: BetterPlayerControlsConfiguration(
      enableProgressBar: true,
      enableProgressBarDrag: true,
      enableQualities: true,
      enableSubtitles: true,
      enableRetry: true,
      enableAudioTracks: true,
      enablePip: true,
      playIcon: Icons.play_circle_outline_rounded,
      skipBackIcon: Icons.replay_10_rounded,
      skipForwardIcon: Icons.forward_10_rounded,
      enableProgressText: true,
      progressBarPlayedColor: AppColor.primaryColor,
      progressBarHandleColor: AppColor.primaryColor,
      overflowMenuIconsColor: AppColor.primaryColor,
      loadingColor: AppColor.white,
    ),
  );


  void initializeVideoPlayer({required int videoIndex, int startFrom = 0}) async{
    // betterPlayerController.setBetterPlayerControlsConfiguration(
    //   betterPlayerConfiguration.controlsConfiguration
    // );
    currentIndexPlaying = videoIndex;
    temp = 2;
    emit(VideoPlayerInitialiazingState());
    
    try {
      if (betterPlayerController.videoPlayerController != null) {
        if(betterPlayerController.isPlaying() ?? false){
          betterPlayerController.pause();
        }
      }
    } catch (e) {
      log("BetterPlayerController is not initialize", name: "VideoPlayer");
    }


    final SingleVimeoVideoDetailModel currentVideo ;
    final SingleVimeoCaptionDetailModel currentVideoCaption ;
    try {
      currentVideo = await videoPlayerController.getSingleVideoDetail(lessonsList[currentIndexPlaying].vimeoVideo);

      currentVideoCaption = await videoPlayerController.getSingleVideoCaptionDetail(lessonsList[currentIndexPlaying].vimeoVideo);

      List<Progressive> progressiveVideos = currentVideo.play!.progressive!;
      progressiveVideos.sort((a, b) {
        int resolutionA = int.parse(a.rendition!.replaceAll('p', ''));
        int resolutionB = int.parse(b.rendition!.replaceAll('p', ''));
        return resolutionA.compareTo(resolutionB);
      });

      Map<String, String> tempResolution = {
       for (var video in progressiveVideos) video.rendition!: video.link!
      } ;

      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        progressiveVideos[progressiveVideos.length-1].link!,
        resolutions: tempResolution,
        liveStream: false,
        useAsmsSubtitles: true,
        subtitles: [
          BetterPlayerSubtitlesSource(
            type: BetterPlayerSubtitlesSourceType.network,
            name: "EN",
            selectedByDefault: true,
            urls: [
              currentVideoCaption.data?[0].link ?? ""
            ],
          ),
        ], 
        // notificationConfiguration: const BetterPlayerNotificationConfiguration(
        //   showNotification: true,
        //   title: "Healing Course",
        //   author: "By Jerry Serjent",
        //   imageUrl: "https://i.vimeocdn.com/video/1908584820-13a2fa9483fe75aa1247d413bb67c9e794a016923794b73bc71c25ab0dfce78f-d",
        //   activityName: "MainActivity",
        // ),
      );

      betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration.copyWith(
          aspectRatio: 16 / 9,
          autoDetectFullscreenDeviceOrientation: true,
          expandToFill: false,
          autoPlay: true,
          handleLifecycle: true,
          allowedScreenSleep: false,

          subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
            alignment: Alignment.center,
          ),
          startAt: Duration(seconds: startFrom),
          eventListener: (event) {
            log("Better player event: ${event.betterPlayerEventType}", name: "VideoPlayer");

            if(event.betterPlayerEventType == BetterPlayerEventType.pause){
              onPause();
            }

            if(event.betterPlayerEventType == BetterPlayerEventType.finished){
              log(">>", name: "VideoPLayer");
              onFinished();
            }
          },
          showPlaceholderUntilPlay: true,
          looping: false,
          placeholder:Image(image: NetworkImage(currentVideo.pictures?.baseLink ?? ""))
        ),
        betterPlayerDataSource: betterPlayerDataSource
      ); 
      
      emit(VideoPlayerInitialiazedState());
      // setPlayListScrollPositionToCurrentIndex();
    } catch (e) {
      log(e.toString(), name: "initializeVideoPlayer");
      emit(VideoPlayerErrorState());
    }
  }


  void setPlaylist(CourseDetailModel course) async{
    // courseDetail = course;
    curriculumLength = course.data!.curriculum!.length;
    curriculumTitle = course.data!.title!;

    for(Curriculum curclm in course.data!.curriculum!){
      lessonsList.add(curclm.title??"");
      lessonsList.addAll(curclm.lessons!);
    }
    
    await setVideoProgressMetaData();
    emit(VideoPlayerPlaylistUpdatedState());
  }

  Future<void> setVideoProgressMetaData() async{
    emit(VideoPlayerSettingVideoProgMetaDataState());
    for(var lesson in lessonsList){
      if(lesson is! String){
        final VideoProgressModel metaData = await videoPlayerController.getSingleVideoPgrogFromLocalDb(lesson.vimeoVideo);
        videoProgressMetaData["${metaData.videoId}"] = metaData;
      }
    }

    emit(VideoPlayerVideoProgMetaDataUpdatedState());
  }

  void onDoubleTapOnPLayer(){
    betterPlayerController.isPlaying()! ? betterPlayerController.pause() : betterPlayerController.play();
  }


  void onPause()async{
    //~ store current video progress
    try {
      await updateMetaData();
      emit(VideoPlayerPausedState());
    } catch (e) {
      log("Error in saving video progress -> ${e.toString()}", name: "VideoPlayer");
    }
  }

  void onFinished() async{
    try {
      await updateMetaData(isFinished: true);

      if(currentIndexPlaying+1 < lessonsList.length){
        int nextVideoIndex = currentIndexPlaying+1;
        dynamic nextVideoKey = lessonsList[nextVideoIndex].vimeoVideo ;
        int startFrom = videoProgressMetaData.containsKey(nextVideoKey)? videoProgressMetaData[nextVideoKey]!.currentPosition! : 0;

        initializeVideoPlayer(videoIndex: nextVideoIndex, startFrom: startFrom);
      }
    } catch (e) {
      log("Error in saving video progress on finish-> ${e.toString()}", name: "VideoPlayer");
    }
  }
  
  Future<void> updateMetaData({bool isFinished = false}) async{
    final videoId = lessonsList[currentIndexPlaying].vimeoVideo;
    final currentPosition = await betterPlayerController.videoPlayerController?.position;
    final totalDuration = betterPlayerController.videoPlayerController?.value.duration;

    if(isFinished){
      await videoPlayerController.saveSingleVideoPgrogToLocalDb(
        videoId,
        totalDuration!,
        totalDuration,
        true,
      );
    }
    else if (currentPosition != null && totalDuration != null) {
      final isCompleted = currentPosition.inSeconds >= totalDuration.inSeconds;

      log("Video current position at: ${currentPosition.inSeconds} seconds", name: "VideoPlayer");
      log("Video duration: ${totalDuration.inSeconds} seconds", name: "VideoPlayer");
      log("Is video completed? $isCompleted", name: "VideoPlayer");

      await videoPlayerController.saveSingleVideoPgrogToLocalDb(
        videoId,
        currentPosition,
        totalDuration,
        isCompleted,
      );
    } else {
      log("Could not fetch video position or duration", name: "VideoPlayer");
    }

    final VideoProgressModel metaData = await videoPlayerController.getSingleVideoPgrogFromLocalDb(videoId);
    videoProgressMetaData["${metaData.videoId}"] = metaData;

    emit(VideoPlayerVideoProgMetaDataUpdatedState());
  }
  
  // void setPlayListScrollPositionToCurrentIndex() {
  //   if (currentIndexPlaying >= 0) {
  //     final context = itemKeys[currentIndexPlaying]?.currentContext;
  //     if (context != null  && context.mounted) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         Scrollable.ensureVisible(
  //           context,
  //           duration: const Duration(milliseconds: 300),
  //           curve: Curves.easeInOut,
  //         );
  //       });
  //     }
  //   }
  // }

}
