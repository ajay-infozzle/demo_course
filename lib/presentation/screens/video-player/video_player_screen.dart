import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:demo_course_video/presentation/cubit/video-player/video_player_cubit.dart';
import 'package:demo_course_video/presentation/screens/video-player/widget/player_widget.dart';
import 'package:demo_course_video/presentation/widget/play_list_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async{
        await context.read<VideoPlayerCubit>().betterPlayerController.pause();
      },
      child: Scaffold(
        backgroundColor: AppColor.appbar,
        body: SafeArea(
          child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
            builder: (context, state) {
              return Container(
                color: AppColor.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PlayerWidget(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceDimens.width * 0.03,
                          vertical: DeviceDimens.width * 0.03),
                      child: Text(
                        "${context.read<VideoPlayerCubit>().lessonsList.length - context.read<VideoPlayerCubit>().courseDetail.data!.curriculum!.length} Videos Available",
                        style: TextStyle(
                            fontSize: DeviceDimens.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            width: DeviceDimens.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: DeviceDimens.width * 0.03,
                                vertical: DeviceDimens.width * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.read<VideoPlayerCubit>().lessonsList[context.read<VideoPlayerCubit>().currentIndexPlaying].lessonTitle ?? "",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: DeviceDimens.width * 0.055),
                                ),
                                // Text(
                                //   context.read<VideoPlayerCubit>().lessonsList[context.read<VideoPlayerCubit>().currentIndexPlaying]. ?? "",
                                //   style: TextStyle(
                                //       color: AppColor.black.withOpacity(.8),
                                //       fontSize: DeviceDimens.width * 0.04),
                                // ),
                              ],
                            ),
                          ),
      
                          PlayListDetailsWidget(
                            onItemTap: (index, currentPosition) async{
                              if(context.read<VideoPlayerCubit>().currentIndexPlaying == index){
                                if(context.read<VideoPlayerCubit>().betterPlayerController.isPlaying() ?? false){
                                  context.read<VideoPlayerCubit>().betterPlayerController.pause();
                                }
                              }
                              else{
                                if(context.read<VideoPlayerCubit>().currentIndexPlaying != -1){
                                  await context.read<VideoPlayerCubit>().updateMetaData();

                                  // ignore: use_build_context_synchronously
                                  context.read<VideoPlayerCubit>().initializeVideoPlayer(videoIndex: index, startFrom: currentPosition);
                                }else{
                                  context.read<VideoPlayerCubit>().initializeVideoPlayer(videoIndex: index, startFrom: currentPosition);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
