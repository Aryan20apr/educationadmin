class NoticesResponse {
  Data? data;

  NoticesResponse({this.data});

  NoticesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Notices>? notices;

  Data({this.msg, this.notices});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['notices'] != null) {
      notices = <Notices>[];
      json['notices'].forEach((v) {
        notices!.add(new Notices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = msg;
    if (notices != null) {
      data['notices'] = notices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notices {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  int? createdBy;
  int? channelId;

  Notices(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.description,
      this.createdBy,
      this.channelId});

  Notices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    description = json['description'];
    createdBy = json['createdBy'];
    channelId = json['ChannelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['title'] = title;
    data['description'] = description;
    data['createdBy'] = createdBy;
    data['ChannelId'] = channelId;
    return data;
  }
}