
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:demo_course_video/data/model/course_detail_model.dart';
import 'package:demo_course_video/domain/controller/home/home_controller.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeController homeController;

  HomeCubit({required this.homeController}) : super(HomeInitial());

  void loadCourse() async{
    try {
      emit(HomeLoadingState());
      print(">>loading course");
      final course = await homeController.fetchCourse();

      emit(HomeLoadedState(course));
    } catch (e) {
      log("Error: ${e.toString()}");
      emit(HomeLoadingState());
    }
  }
}
