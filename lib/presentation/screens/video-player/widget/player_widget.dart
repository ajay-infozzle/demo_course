import 'package:better_player_plus/better_player_plus.dart';
import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:demo_course_video/presentation/cubit/video-player/video_player_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  GlobalKey betterPlayerKey = GlobalKey();

  @override
  void initState() {
    // setupPip();

    super.initState();
  }

  // void setupPip() async{
  //   final isPipSupported = await betterPlayerController.isPictureInPictureSupported() ;
  //   log(">>${isPipSupported.toString()}", name: "VideoPlayer");
  //   if(isPipSupported){
  //     betterPlayerController.enablePictureInPicture(betterPlayerKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (context, state) {
        return Container(
          width: DeviceDimens.width,
          color: AppColor.black,
          child: state is VideoPlayerInitialiazedState || state is VideoPlayerPausedState
          ? BetterPlayerMultipleGestureDetector(
              onDoubleTap: () {
                context.read<VideoPlayerCubit>().onDoubleTapOnPLayer();
              },
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BetterPlayer(
                      controller: context.read<VideoPlayerCubit>().betterPlayerController,
                      key: betterPlayerKey,
                    ),
                  ],
                ),
              ),
            )
          : const AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(child: CircularProgressIndicator(color: AppColor.white,),),
          ),
        );
      },
    );
  }
}
