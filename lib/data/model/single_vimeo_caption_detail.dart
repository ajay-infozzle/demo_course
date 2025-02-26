class SingleVimeoCaptionDetailModel {
  List<Data>? data;

  SingleVimeoCaptionDetailModel({this.data});

  SingleVimeoCaptionDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? uri;
  bool? active;
  String? type;
  String? language;
  String? displayLanguage;
  int? id;
  String? link;
  int? linkExpiresTime;
  String? sourceLink;
  int? sourceLinkExpiresTime;
  String? hlsLink;
  int? hlsLinkExpiresTime;
  String? name;

  Data(
      {this.uri,
      this.active,
      this.type,
      this.language,
      this.displayLanguage,
      this.id,
      this.link,
      this.linkExpiresTime,
      this.sourceLink,
      this.sourceLinkExpiresTime,
      this.hlsLink,
      this.hlsLinkExpiresTime,
      this.name});

  Data.fromJson(Map<dynamic, dynamic> json) {
    uri = json['uri'];
    active = json['active'];
    type = json['type'];
    language = json['language'];
    displayLanguage = json['display_language'];
    id = json['id'];
    link = json['link'];
    linkExpiresTime = json['link_expires_time'];
    sourceLink = json['source_link'];
    sourceLinkExpiresTime = json['source_link_expires_time'];
    hlsLink = json['hls_link'];
    hlsLinkExpiresTime = json['hls_link_expires_time'];
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['active'] = active;
    data['type'] = type;
    data['language'] = language;
    data['display_language'] = displayLanguage;
    data['id'] = id;
    data['link'] = link;
    data['link_expires_time'] = linkExpiresTime;
    data['source_link'] = sourceLink;
    data['source_link_expires_time'] = sourceLinkExpiresTime;
    data['hls_link'] = hlsLink;
    data['hls_link_expires_time'] = hlsLinkExpiresTime;
    data['name'] = name;
    return data;
  }
}
