// import 'package:demo_course_video/data/repository/course/course_repo_impl.dart';
// import 'package:demo_course_video/data/repository/video/video_progress_repo_impl.dart';
// import 'package:demo_course_video/data/services/api_services.dart';
// import 'package:demo_course_video/domain/controller/home/home_controller.dart';
// import 'package:demo_course_video/domain/controller/video/video_player_controller.dart';
// import 'package:demo_course_video/domain/usecases/course/course_usecase_impl.dart';
// import 'package:demo_course_video/domain/usecases/video/video_use_case.dart';


// class Di{
//   static final apiService = ApiService();
  
//   static final playlistRepo = CourseRepoImpl(apiService);
//   static final fetchCourseUsecaseImpl = FetchCourseUsecaseImpl(playlistRepo);

//   static final homeController = HomeController(fetchCourseUseCase: fetchCourseUsecaseImpl);

//   //~ Video-related dependencies
//   static final videoProgressRepo = VideoProgressRepoImpl(apiService: apiService);
//   static final videoUseCase = VideoUseCase(videoProgressRepo: videoProgressRepo);
//   static final videoController = VideoPlayerController(videoUseCase: videoUseCase);
// }