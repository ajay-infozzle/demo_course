import 'package:demo_course_video/data/model/single_vimeo_caption_detail.dart';
import 'package:demo_course_video/data/model/single_vimeo_video_detail_model.dart';
import 'package:demo_course_video/data/model/video_progress_model.dart';
import 'package:demo_course_video/domain/usecases/video/video_use_case.dart';

class VideoPlayerController {
  final VideoUseCase videoUseCase;

  VideoPlayerController({required this.videoUseCase});

  Future<VideoProgressModel> getSingleVideoPgrogFromLocalDb(dynamic videoId) async{
   return await videoUseCase.executeSingleVideoPgrogFromLocalDb(videoId);
  }

  Future<void> saveSingleVideoPgrogToLocalDb(dynamic videoId, Duration currentPosition, Duration totalDuration, bool isCompleted) async{
   await videoUseCase.executeSingleVideoPgrogToLocalDb(videoId, currentPosition, totalDuration, isCompleted);
  }

  Future<SingleVimeoVideoDetailModel> getSingleVideoDetail(dynamic videoId) async{
    return await videoUseCase.executeSingleVideoDetail(videoId);
  }

  Future<SingleVimeoCaptionDetailModel> getSingleVideoCaptionDetail(dynamic videoId) async{
    return await videoUseCase.executeSingleVideoCaptionDetail(videoId);
  }
}