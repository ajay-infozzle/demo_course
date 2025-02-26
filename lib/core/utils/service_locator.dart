
import 'package:demo_course_video/data/repository/course/course_repo_impl.dart';
import 'package:demo_course_video/data/repository/video/video_progress_repo_impl.dart';
import 'package:demo_course_video/data/services/api_services.dart';
import 'package:demo_course_video/domain/controller/home/home_controller.dart';
import 'package:demo_course_video/domain/controller/video/video_player_controller.dart';
import 'package:demo_course_video/domain/usecases/course/course_usecase_impl.dart';
import 'package:demo_course_video/domain/usecases/video/video_use_case.dart';
import 'package:demo_course_video/presentation/cubit/home/home_cubit.dart';
import 'package:demo_course_video/presentation/cubit/internet/internet_cubit.dart';
import 'package:demo_course_video/presentation/cubit/video-player/video_player_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Services
  getIt.registerLazySingleton(() => ApiService());

  // Repositories
  getIt.registerLazySingleton(() => CourseRepoImpl(getIt<ApiService>()));
  getIt.registerLazySingleton(() => VideoProgressRepoImpl(apiService: getIt<ApiService>()));

  // Use Cases
  getIt.registerLazySingleton(() => FetchCourseUsecaseImpl(getIt<CourseRepoImpl>()));
  getIt.registerLazySingleton(() => VideoUseCase(videoProgressRepo: getIt<VideoProgressRepoImpl>()));

  // Controllers
  getIt.registerLazySingleton(() => HomeController(fetchCourseUseCase: getIt<FetchCourseUsecaseImpl>()));
  getIt.registerLazySingleton(() => VideoPlayerController(videoUseCase: getIt<VideoUseCase>()));

  // Cubits
  getIt.registerFactory(() => InternetCubit());
  getIt.registerFactory(() => HomeCubit(homeController: getIt<HomeController>()));
  getIt.registerFactory(() => VideoPlayerCubit(videoPlayerController: getIt<VideoPlayerController>()));

  print(">>all dependecy injected");
}