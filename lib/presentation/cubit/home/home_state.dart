part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}
final class HomeLoadedState extends HomeState {
  final CourseDetailModel course ;
  HomeLoadedState(this.course);
}
final class HomeLoadingErrorState extends HomeState {}
