import 'package:demo_course_video/data/model/course_detail_model.dart';
import 'package:demo_course_video/data/repository/course/course_repo.dart';
import 'package:demo_course_video/data/services/api_services.dart';

class CourseRepoImpl implements CourseRepo {
  final ApiService apiService;

  CourseRepoImpl(this.apiService);
  
  @override
  Future<CourseDetailModel> getCourse() async{
    final response = await apiService.fetchCourse();
    return response;
  }

}