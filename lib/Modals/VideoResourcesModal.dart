class VideoResourcesData {
  Data? _data;

  VideoResourcesData({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  VideoResourcesData.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _msg;
  List<Videos>? _videos;

  Data({String? msg, List<Videos>? videos}) {
    if (msg != null) {
      _msg = msg;
    }
    if (videos != null) {
      _videos = videos;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Videos>? get videos => _videos;
  set videos(List<Videos>? videos) => _videos = videos;

  Data.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    if (json['videos'] != null) {
      _videos = <Videos>[];
      json['videos'].forEach((v) {
        _videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = _msg;
    if (_videos != null) {
      data['videos'] = _videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? _id;
  String? _createdAt;
  String? _updatedAt;
  String? _title;
  String? _link;
  bool? _isPaid;
  String? _type;
  String? _description;
  int? _channelId;
  int? _createdBy;

  Videos(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? title,
      String? link,
      bool? isPaid,
      String? type,
      String? description,
      int? channelId,
      int? createdBy}) {
    if (id != null) {
      _id = id;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (title != null) {
      _title = title;
    }
    if (link != null) {
      _link = link;
    }
    if (isPaid != null) {
      _isPaid = isPaid;
    }
    if (type != null) {
      _type = type;
    }
    if (description != null) {
      _description = description;
    }
    if (channelId != null) {
      _channelId = channelId;
    }
    if (createdBy != null) {
      _createdBy = createdBy;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get link => _link;
  set link(String? link) => _link = link;
  bool? get isPaid => _isPaid;
  set isPaid(bool? isPaid) => _isPaid = isPaid;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get channelId => _channelId;
  set channelId(int? channelId) => _channelId = channelId;
  int? get createdBy => _createdBy;
  set createdBy(int? createdBy) => _createdBy = createdBy;

  Videos.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _title = json['title'];
    _link = json['link'];
    _isPaid = json['isPaid'];
    _type = json['type'];
    _description = json['description'];
    _channelId = json['channelId'];
    _createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['title'] = _title;
    data['link'] = _link;
    data['isPaid'] = _isPaid;
    data['type'] = _type;
    data['description'] = _description;
    data['channelId'] = _channelId;
    data['createdBy'] = _createdBy;
    return data;
  }
}