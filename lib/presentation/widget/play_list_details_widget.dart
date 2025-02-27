import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:demo_course_video/core/utils/helpers.dart';
import 'package:demo_course_video/presentation/cubit/video-player/video_player_cubit.dart';
import 'package:demo_course_video/presentation/widget/play_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayListDetailsWidget extends StatelessWidget {
  final Function(int index, int currentPosition) onItemTap;

  const PlayListDetailsWidget({super.key, required this.onItemTap});
  

  @override
  Widget build(BuildContext context) {
    int videoNumber = 0;
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (context, state) {
        
        if(state is VideoPlayerSettingVideoProgMetaDataState || state is VideoPlayerInitial){
          return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor,),);
        }
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              controller: context.read<VideoPlayerCubit>().temp==2?context.read<VideoPlayerCubit>().playlistScrollController:null,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: context.read<VideoPlayerCubit>().lessonsList.length,
              itemBuilder: (context, index) {
                final videoPlapeyCubit = context.read<VideoPlayerCubit>();
                final currentItem = context.read<VideoPlayerCubit>().lessonsList[index];
                
                //~ store item keys
                // videoPlapeyCubit.itemKeys[index] = GlobalKey(debugLabel: index.toString());

                if(currentItem is String){
                  return Container(
                    // key: videoPlapeyCubit.itemKeys[index],
                    padding: EdgeInsets.symmetric(horizontal: DeviceDimens.width*0.05,vertical: DeviceDimens.width*0.03),
                    width: DeviceDimens.width,
                    child: Text(
                      currentItem,
                      style: TextStyle(
                        color: AppColor.meditationColor,
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceDimens.width*0.045,
                        overflow: TextOverflow.ellipsis
                      ),
                      maxLines: 1,
                    ),
                  );
                }else{
                  // if(videoNumber == (videoPlapeyCubit.lessonsList.length-videoPlapeyCubit.courseDetail.data!.curriculum!.length)){
                  if(videoNumber == (videoPlapeyCubit.lessonsList.length-videoPlapeyCubit.curriculumLength)){
                    videoNumber = 0;
                  }
                  videoNumber++;
                }

                final isMetaDataAvailable = videoPlapeyCubit.videoProgressMetaData.containsKey(currentItem.vimeoVideo) ;
                final currentPosition = isMetaDataAvailable ? videoPlapeyCubit.videoProgressMetaData[currentItem.vimeoVideo]!.currentPosition : 0 ;
                final totalDuration = isMetaDataAvailable ? videoPlapeyCubit.videoProgressMetaData[currentItem.vimeoVideo]!.totalDuration : 0 ;
                final isCompleted = isMetaDataAvailable ? videoPlapeyCubit.videoProgressMetaData[currentItem.vimeoVideo]!.isCompleted : false;

                return PlayListItemWidget(
                  // key: videoPlapeyCubit.itemKeys[index],
                  index: index + 1,
                  videoCounter: videoNumber,
                  title: currentItem.lessonTitle ?? "",
                  subTitle: "Duration - ${formatDuration(currentItem.duration ?? 0)}",
                  onTap: () {
                    onItemTap(index, isMetaDataAvailable ? currentPosition! : 0);
                  },
                  isPreviouslyViewed: isMetaDataAvailable,
                  progressValue: isMetaDataAvailable ? ( currentPosition! / totalDuration!) : 0.0,
                  isViewed: isCompleted!,
                  isPlaying: videoPlapeyCubit.currentIndexPlaying == index,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
