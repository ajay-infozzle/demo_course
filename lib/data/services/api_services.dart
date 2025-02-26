import 'dart:convert';
import 'dart:developer';
import 'package:demo_course_video/core/constants.dart';
import 'package:demo_course_video/data/model/course_detail_model.dart';
import 'package:demo_course_video/data/model/single_vimeo_caption_detail.dart';
import 'package:demo_course_video/data/model/single_vimeo_video_detail_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  
  Future<CourseDetailModel> fetchCourse() async {
    final response = await http.get(Uri.parse(AppConstant.playlistBaseUrl)).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CourseDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load course');
    }
  }

  Future<SingleVimeoVideoDetailModel> fetchVideoDetail( {required dynamic videoId} ) async {
    try {
      final response = await http.get(
      Uri.parse("${AppConstant.singleVimeoVideoDetailBaseUrl}$videoId"),
        headers: {
          'Authorization': 'Bearer ${AppConstant.vimeoAccessToken}', 
          'Content-Type': 'application/json', 
        },
      );

      log(response.body, name: "fetchVideoDetail");
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return SingleVimeoVideoDetailModel.fromJson(data);
      } else {
        throw Exception('Failed to load video detail');
      }
    } catch (e) {
      rethrow ;
    }
  }

  Future<SingleVimeoCaptionDetailModel> fetchVideoCaptionDetail( {required dynamic videoId} ) async {
    try {
      final response = await http.get(
      Uri.parse("${AppConstant.singleVimeoVideoDetailBaseUrl}$videoId/texttracks"),
        headers: {
          'Authorization': 'Bearer ${AppConstant.vimeoAccessToken}', 
          'Content-Type': 'application/json', 
        },
      );

      log(response.body, name: "fetchVideoCaptionDetail");
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return SingleVimeoCaptionDetailModel.fromJson(data);
      } else {
        throw Exception('Failed to load video caption detail');
      }
    } catch (e) {
      rethrow ;
    }
  }

}
