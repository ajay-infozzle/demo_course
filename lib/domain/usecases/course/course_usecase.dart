import 'package:demo_course_video/data/model/course_detail_model.dart';

abstract class FetchCourseUseCase {
  Future<CourseDetailModel> execute();
}