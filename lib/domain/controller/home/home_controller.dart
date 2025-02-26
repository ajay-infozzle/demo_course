import 'package:demo_course_video/data/model/course_detail_model.dart';
import 'package:demo_course_video/domain/usecases/course/course_usecase.dart';

class HomeController {
  final FetchCourseUseCase fetchCourseUseCase;

  HomeController({required this.fetchCourseUseCase});

  Future<CourseDetailModel> fetchCourse() async {
    return await fetchCourseUseCase.execute();
  }
}