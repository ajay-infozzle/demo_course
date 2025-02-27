import 'package:demo_course_video/core/routes/route_name.dart';
import 'package:demo_course_video/core/utils/colors.dart';
import 'package:demo_course_video/core/utils/dimens.dart';
import 'package:demo_course_video/presentation/cubit/home/home_cubit.dart';
import 'package:demo_course_video/presentation/cubit/video-player/video_player_cubit.dart';
import 'package:demo_course_video/presentation/screens/home/widget/home_loader_widget.dart';
import 'package:demo_course_video/presentation/screens/home/widget/thumbnail_preview_widget.dart';
import 'package:demo_course_video/presentation/widget/play_list_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().loadCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appbar,
        appBar: AppBar(
          backgroundColor: AppColor.appbar,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            'Course Videos',
            style: TextStyle(color: AppColor.white),
          ),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if(state is HomeLoadedState){
              context.read<VideoPlayerCubit>().setPlaylist(state.course);
            }
          },
          builder: (context, state) {
            if(state is HomeLoadingState || state is HomeLoadingErrorState){
              return const HomeLoaderWidget();
            }
            return Container(
              width: DeviceDimens.width,
              color: AppColor.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThumbnailPreviewWidget(
                      title: "",
                      thumbnailUrl:
                          "https://i.vimeocdn.com/video/1908584820-13a2fa9483fe75aa1247d413bb67c9e794a016923794b73bc71c25ab0dfce78f-d",
                      onPlay: () {
                        context.read<VideoPlayerCubit>().initializeVideoPlayer(videoIndex: 1);
                        context.pushNamed(RouteName.videoPlayerscreen);
                      }),

                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceDimens.width * 0.03,
                        vertical: DeviceDimens.width * 0.03),
                    child: Text(
                      "${context.read<VideoPlayerCubit>().lessonsList.length - context.read<VideoPlayerCubit>().curriculumLength } Videos Available",
                      // "${context.read<VideoPlayerCubit>().lessonsList.length - context.read<VideoPlayerCubit>().courseDetail.data.curriculum.length } Videos Available",
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
                                context.read<VideoPlayerCubit>().curriculumTitle,
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: DeviceDimens.width * 0.055),
                              ),
                              // Text(
                              //   context.read<VideoPlayerCubit>().courseDetail.data!.content!,
                              //   style: TextStyle(
                              //       color: AppColor.black.withOpacity(.8),
                              //       fontSize: DeviceDimens.width * 0.04),
                              // ),
                            ],
                          ),
                        ),

                        PlayListDetailsWidget(
                          onItemTap: (index, currentPosition) async{
                            if(context.read<VideoPlayerCubit>().currentIndexPlaying != -1){
                              await context.read<VideoPlayerCubit>().updateMetaData();

                              // ignore: use_build_context_synchronously
                              context.read<VideoPlayerCubit>().initializeVideoPlayer(videoIndex: index, startFrom: currentPosition);
                            }else{
                              context.read<VideoPlayerCubit>().initializeVideoPlayer(videoIndex: index, startFrom: currentPosition);
                            }

                            // ignore: use_build_context_synchronously
                            context.pushNamed(RouteName.videoPlayerscreen);
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
    );
  }
}
