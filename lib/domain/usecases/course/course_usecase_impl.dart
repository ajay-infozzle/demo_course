import 'package:demo_course_video/data/model/course_detail_model.dart';
import 'package:demo_course_video/data/repository/course/course_repo.dart';
import 'package:demo_course_video/domain/usecases/course/course_usecase.dart';


class FetchCourseUsecaseImpl implements FetchCourseUseCase{
  final CourseRepo repository ;

  FetchCourseUsecaseImpl(this.repository);

  @override
  Future<CourseDetailModel> execute() async{
   return await repository.getCourse();
  }

}