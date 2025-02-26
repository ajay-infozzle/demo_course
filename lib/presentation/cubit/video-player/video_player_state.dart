part of 'video_player_cubit.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoPlayerInitialiazingState extends VideoPlayerState {}
final class VideoPlayerInitialiazedState extends VideoPlayerState {}
final class VideoPlayerPlayingState extends VideoPlayerState {}
final class VideoPlayerPausedState extends VideoPlayerState {}
final class VideoPlayerErrorState extends VideoPlayerState {}


final class VideoPlayerPlaylistLoadingState extends VideoPlayerState {}
final class VideoPlayerPlaylistUpdatedState extends VideoPlayerState {}
final class VideoPlayerPlaylistErrorState extends VideoPlayerState {}

final class VideoPlayerSettingVideoProgMetaDataState extends VideoPlayerState {}
final class VideoPlayerVideoProgMetaDataUpdatedState extends VideoPlayerState {}
