import 'package:demo_course_video/data/model/single_vimeo_caption_detail.dart';
import 'package:demo_course_video/data/model/single_vimeo_video_detail_model.dart';
import 'package:demo_course_video/data/model/video_progress_model.dart';

abstract class VideoProgressRepo {
  Future<void> saveSingleVideoPgrogFromLocalDb({required dynamic videoId, required  Duration currentPosition, required Duration totalDuration, required bool isCompleted});
  Future<VideoProgressModel> getSingleVideoPgrogFromLocalDb({required dynamic videoId});

  Future<SingleVimeoVideoDetailModel> getSingleVideoDetail({required dynamic videoId});
  Future<SingleVimeoCaptionDetailModel> getSingleVideoCaptionDetail({required dynamic videoId});
}