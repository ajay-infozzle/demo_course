import 'package:demo_course_video/core/constants.dart';
import 'package:demo_course_video/data/model/single_vimeo_caption_detail.dart';
import 'package:demo_course_video/data/model/single_vimeo_video_detail_model.dart';
import 'package:demo_course_video/data/model/video_progress_model.dart';
import 'package:demo_course_video/data/repository/video/video_progress_repo.dart';
import 'package:demo_course_video/data/services/api_services.dart';
import 'package:hive/hive.dart';


class VideoProgressRepoImpl implements VideoProgressRepo{
  final ApiService apiService;

  VideoProgressRepoImpl({required this.apiService});

  @override
  Future<void> saveSingleVideoPgrogFromLocalDb({required dynamic videoId, required  Duration currentPosition, required Duration totalDuration, required bool isCompleted}) async{
    VideoProgressModel videoProgressModel = VideoProgressModel(currentPosition: currentPosition.inSeconds, totalDuration: totalDuration.inSeconds, videoId: videoId, isCompleted: isCompleted);
    
    final Box videoBox = await Hive.openBox(AppConstant.progressMetaDataKey);
    await videoBox.put("$videoId", videoProgressModel.toJson());
  }

  @override
  Future<VideoProgressModel> getSingleVideoPgrogFromLocalDb({required dynamic videoId}) async{
    final Box videoBox = await Hive.openBox(AppConstant.progressMetaDataKey);

    final savedProgress = await videoBox.get("$videoId", defaultValue: {});

    if (savedProgress is Map<dynamic, dynamic>) {
      return VideoProgressModel.fromJson(
        savedProgress.map((key, value) => MapEntry(key.toString(), value)),
      );
    }
    else{
      return VideoProgressModel.fromJson(savedProgress);
    }
  }

  @override
  Future<SingleVimeoVideoDetailModel> getSingleVideoDetail({required dynamic videoId}) async{
    final Box videoDetailBox = await Hive.openBox(AppConstant.videoDetailMetaDataKey);
    final savedDetail = await videoDetailBox.get("$videoId", defaultValue: {});

    if (savedDetail is Map<dynamic, dynamic> && savedDetail.isNotEmpty) {
      final detail = SingleVimeoVideoDetailModel.fromJson(
        savedDetail.map((key, value) => MapEntry(key.toString(), value)),
      );
      

      final DateTime expirationTime = DateTime.parse(detail.play!.progressive![0].linkExpirationTime!);
      final DateTime now = DateTime.now().toUtc();

      if(expirationTime.difference(now).inHours >= 1){
        return detail ;
      }
      else{
        final response = await apiService.fetchVideoDetail(videoId: videoId);
        await videoDetailBox.put("$videoId", response.toJson());

        return response;
      }
    }
    else{
      final response = await apiService.fetchVideoDetail(videoId: videoId);
      await videoDetailBox.put("$videoId", response.toJson());
      
      return response;
    } 
  }

  @override
  Future<SingleVimeoCaptionDetailModel> getSingleVideoCaptionDetail({required dynamic videoId}) async{
    final Box videoCaptionDetailBox = await Hive.openBox(AppConstant.videoCaptionDetailMetaDataKey);
    final savedDetail = await videoCaptionDetailBox.get("$videoId", defaultValue: {});

    if (savedDetail is Map<dynamic, dynamic> && savedDetail.isNotEmpty) {
      final detail = SingleVimeoCaptionDetailModel.fromJson(
        savedDetail.map((key, value) => MapEntry(key.toString(), value)),
      );
      

      final DateTime expirationTime = DateTime.parse(detail.data![0].linkExpiresTime.toString());
      final DateTime now = DateTime.now().toUtc();

      if(expirationTime.difference(now).inHours >= 1){
        return detail ;
      }
      else{
        final response = await apiService.fetchVideoCaptionDetail(videoId: videoId);
        await videoCaptionDetailBox.put("$videoId", response.toJson());
        
        return response;
      }
    }
    else{
      final response = await apiService.fetchVideoCaptionDetail(videoId: videoId);
      await videoCaptionDetailBox.put("$videoId", response.toJson());
      
      return response;
    } 
  }

}