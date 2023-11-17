class CreateNoticeResponse {
  Data? data;

  CreateNoticeResponse({this.data});

  CreateNoticeResponse.fromJson(Map<String, dynamic> json) {
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
  Notice? notice;

  Data({this.msg, this.notice});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    notice =
        json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = msg;
    if (notice != null) {
      data['notice'] = notice!.toJson();
    }
    return data;
  }
}

class Notice {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  int? createdBy;
  int? channelId;

  Notice(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.description,
      this.createdBy,
      this.channelId});

  Notice.fromJson(Map<String, dynamic> json) {
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