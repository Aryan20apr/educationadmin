class VideoResourcesData {
  Data? data;

  VideoResourcesData({this.data});

  VideoResourcesData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? msg;
  List<Videos>? videos;

  Data({this.msg, this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = msg;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? link;
  bool? isPaid;
  String? type;
  bool? isLive;
  String? startDate;
  String? startTime;
  Null? description;
  int? channelId;
  int? createdBy;

  Videos(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.link,
      this.isPaid,
      this.type,
      this.isLive,
      this.startDate,
      this.startTime,
      this.description,
      this.channelId,
      this.createdBy});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    link = json['link'];
    isPaid = json['isPaid'];
    type = json['type'];
    isLive = json['isLive'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    description = json['description'];
    channelId = json['channelId'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['title'] = title;
    data['link'] = link;
    data['isPaid'] = isPaid;
    data['type'] = type;
    data['isLive'] = isLive;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['description'] = description;
    data['channelId'] = channelId;
    data['createdBy'] = createdBy;
    return data;
  }
}