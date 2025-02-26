class SingleVimeoVideoDetailModel {
  String? uri;
  String? name;
  String? description;
  String? type;
  int? duration;
  int? width;
  String? language;
  int? height;
  List<Download>? download;
  Play? play;
  Pictures? pictures;
  String? status;
  bool? isPlayable;
  bool? hasAudio;

  SingleVimeoVideoDetailModel(
      {this.uri,
      this.name,
      this.description,
      this.type,
      this.duration,
      this.width,
      this.language,
      this.height,
      this.download,
      this.play,
      this.pictures,
      this.status,
      this.isPlayable,
      this.hasAudio});

  SingleVimeoVideoDetailModel.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    duration = json['duration'];
    width = json['width'];
    language = json['language'];
    height = json['height'];
    if (json['download'] != null) {
      download = <Download>[];
      json['download'].forEach((v) {
        download!.add(Download.fromJson(v));
      });
    }
    play = json['play'] != null ? Play.fromJson(json['play']) : null;
    pictures = json['pictures'] != null ? Pictures.fromJson(json['pictures']) : null;
    status = json['status'];
    isPlayable = json['is_playable'];
    hasAudio = json['has_audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['duration'] = duration;
    data['width'] = width;
    data['language'] = language;
    data['height'] = height;
    if (download != null) {
      data['download'] = download!.map((v) => v.toJson()).toList();
    }
    if (play != null) {
      data['play'] = play!.toJson();
    }
    if (pictures != null) {
      data['pictures'] = pictures!.toJson();
    }
    data['status'] = status;
    data['is_playable'] = isPlayable;
    data['has_audio'] = hasAudio;
    return data;
  }
}

class Download {
  String? quality;
  String? rendition;
  String? type;
  int? width;
  int? height;
  String? expires;
  String? link;
  String? createdTime;
  int? fps;
  int? size;
  String? publicName;
  String? sizeShort;

  Download(
      {this.quality,
      this.rendition,
      this.type,
      this.width,
      this.height,
      this.expires,
      this.link,
      this.createdTime,
      this.fps,
      this.size,
      this.publicName,
      this.sizeShort});

  Download.fromJson(Map<dynamic, dynamic> json) {
    quality = json['quality'];
    rendition = json['rendition'];
    type = json['type'];
    width = json['width'];
    height = json['height'];
    expires = json['expires'];
    link = json['link'];
    createdTime = json['created_time'];
    fps = json['fps'];
    size = json['size'];
    publicName = json['public_name'];
    sizeShort = json['size_short'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['quality'] = quality;
    data['rendition'] = rendition;
    data['type'] = type;
    data['width'] = width;
    data['height'] = height;
    data['expires'] = expires;
    data['link'] = link;
    data['created_time'] = createdTime;
    data['fps'] = fps;
    data['size'] = size;
    data['public_name'] = publicName;
    data['size_short'] = sizeShort;
    return data;
  }
}

class Play {
  List<Progressive>? progressive;
  Hls? hls;
  Hls? dash;
  String? status;

  Play({this.progressive, this.hls, this.dash, this.status});

  Play.fromJson(Map<dynamic, dynamic> json) {
    if (json['progressive'] != null) {
      progressive = <Progressive>[];
      json['progressive'].forEach((v) {
        progressive!.add(Progressive.fromJson(v));
      });
    }
    hls = json['hls'] != null ? Hls.fromJson(json['hls']) : null;
    dash = json['dash'] != null ? Hls.fromJson(json['dash']) : null;
    status = json['status'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (progressive != null) {
      data['progressive'] = progressive!.map((v) => v.toJson()).toList();
    }
    if (hls != null) {
      data['hls'] = hls!.toJson();
    }
    if (dash != null) {
      data['dash'] = dash!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Pictures {
  String? baseLink;

  Pictures({this.baseLink});

  Pictures.fromJson(Map<dynamic, dynamic> json) {
    baseLink = json['base_link'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_link'] = baseLink;
    return data;
  }
}

class Progressive {
  String? type;
  String? codec;
  int? width;
  int? height;
  String? linkExpirationTime;
  String? link;
  String? createdTime;
  int? fps;
  int? size;
  String? rendition;

  Progressive(
      {this.type,
      this.codec,
      this.width,
      this.height,
      this.linkExpirationTime,
      this.link,
      this.createdTime,
      this.fps,
      this.size,
      this.rendition});

  Progressive.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    codec = json['codec'];
    width = json['width'];
    height = json['height'];
    linkExpirationTime = json['link_expiration_time'];
    link = json['link'];
    createdTime = json['created_time'];
    fps = json['fps'];
    size = json['size'];
    rendition = json['rendition'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['codec'] = codec;
    data['width'] = width;
    data['height'] = height;
    data['link_expiration_time'] = linkExpirationTime;
    data['link'] = link;
    data['created_time'] = createdTime;
    data['fps'] = fps;
    data['size'] = size;
    data['rendition'] = rendition;
    return data;
  }
}

class Hls {
  String? linkExpirationTime;
  String? link;

  Hls({this.linkExpirationTime, this.link});

  Hls.fromJson(Map<dynamic, dynamic> json) {
    linkExpirationTime = json['link_expiration_time'];
    link = json['link'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link_expiration_time'] = linkExpirationTime;
    data['link'] = link;
    return data;
  }
}
