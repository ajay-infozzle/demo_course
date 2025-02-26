import 'package:demo_course_video/data/model/single_vimeo_caption_detail.dart';
import 'package:demo_course_video/data/model/single_vimeo_video_detail_model.dart';
import 'package:demo_course_video/data/model/video_progress_model.dart';
import 'package:demo_course_video/data/repository/video/video_progress_repo.dart';

class VideoUseCase {
  
  final VideoProgressRepo videoProgressRepo;

  VideoUseCase({required this.videoProgressRepo});
  
  Future<VideoProgressModel> executeSingleVideoPgrogFromLocalDb(dynamic videoId) async{
   return await videoProgressRepo.getSingleVideoPgrogFromLocalDb(videoId: videoId);
  }

  Future<void> executeSingleVideoPgrogToLocalDb(dynamic videoId, Duration currentPosition, Duration totalDuration, bool isCompleted) async{
   await videoProgressRepo.saveSingleVideoPgrogFromLocalDb(
    videoId: videoId, 
    currentPosition: currentPosition,
    totalDuration: totalDuration,
    isCompleted: isCompleted
   );
  }

  Future<SingleVimeoVideoDetailModel> executeSingleVideoDetail(dynamic videoId) async{
   return await videoProgressRepo.getSingleVideoDetail(videoId: videoId);
  }

  Future<SingleVimeoCaptionDetailModel> executeSingleVideoCaptionDetail(dynamic videoId) async{
   return await videoProgressRepo.getSingleVideoCaptionDetail(videoId: videoId);
  }

}