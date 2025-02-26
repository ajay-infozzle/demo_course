class CourseDetailModel {
  bool? success;
  String? message;
  Data? data;

  CourseDetailModel({this.success, this.message, this.data});

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? content;
  String? status;
  String? duration;
  String? level;
  String? students;
  String? maxStudents;
  String? retakeCount;
  String? hasFinish;
  String? regularPrice;
  String? salePrice;
  String? saleStart;
  String? saleEnd;
  String? price;
  String? totalSales;
  List<Curriculum>? curriculum;

  Data(
      {this.title,
      this.content,
      this.status,
      this.duration,
      this.level,
      this.students,
      this.maxStudents,
      this.retakeCount,
      this.hasFinish,
      this.regularPrice,
      this.salePrice,
      this.saleStart,
      this.saleEnd,
      this.price,
      this.totalSales,
      this.curriculum});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    status = json['status'];
    duration = json['duration'];
    level = json['level'];
    students = json['students'];
    maxStudents = json['max_students'];
    retakeCount = json['retake_count'];
    hasFinish = json['has_finish'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    saleStart = json['sale_start'];
    saleEnd = json['sale_end'];
    price = json['price'];
    totalSales = json['total_sales'];
    if (json['curriculum'] != null) {
      curriculum = <Curriculum>[];
      json['curriculum'].forEach((v) {
        curriculum!.add(Curriculum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['status'] = status;
    data['duration'] = duration;
    data['level'] = level;
    data['students'] = students;
    data['max_students'] = maxStudents;
    data['retake_count'] = retakeCount;
    data['has_finish'] = hasFinish;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['sale_start'] = saleStart;
    data['sale_end'] = saleEnd;
    data['price'] = price;
    data['total_sales'] = totalSales;
    if (curriculum != null) {
      data['curriculum'] = curriculum!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Curriculum {
  String? title;
  String? description;
  List<Lessons>? lessons;

  Curriculum({this.title, this.description, this.lessons});

  Curriculum.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(Lessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lessons {
  String? lessonTitle;
  String? vimeoVideo;
  int? duration;

  Lessons({this.lessonTitle, this.vimeoVideo, this.duration});

  Lessons.fromJson(Map<String, dynamic> json) {
    lessonTitle = json['lesson_title'];
    vimeoVideo = json['vimeo_video'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lesson_title'] = lessonTitle;
    data['vimeo_video'] = vimeoVideo;
    data['duration'] = duration;
    return data;
  }
}
