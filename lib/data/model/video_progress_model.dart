class VideoProgressModel {
  dynamic videoId;
  int? currentPosition;
  int? totalDuration;
  bool? isCompleted;

  VideoProgressModel({this.videoId, this.currentPosition, this.totalDuration, this.isCompleted});

  VideoProgressModel.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    currentPosition = json['currentPosition'];
    totalDuration = json['totalDuration'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['currentPosition'] = currentPosition;
    data['totalDuration'] = totalDuration;
    data['isCompleted'] = isCompleted;
    return data;
  }
}
