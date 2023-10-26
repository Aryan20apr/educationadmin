class VideoUploadResponseModal {
  VideoUploadData? _data;

  VideoUploadResponseModal({VideoUploadData? data}) {
    if (data != null) {
      _data = data;
    }
  }

  VideoUploadData? get data => _data;
  set data(VideoUploadData? data) => _data = data;

  VideoUploadResponseModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? VideoUploadData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class VideoUploadData {
  String? _msg;
  Resource? _resource;

  VideoUploadData({String? msg, Resource? resource}) {
    if (msg != null) {
      _msg = msg;
    }
    if (resource != null) {
      _resource = resource;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  Resource? get resource => _resource;
  set resource(Resource? resource) => _resource = resource;

  VideoUploadData.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _resource = json['resource'] != null
        ? Resource.fromJson(json['resource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = _msg;
    if (_resource != null) {
      data['resource'] = _resource!.toJson();
    }
    return data;
  }
}

class Resource {
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

  Resource(
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

  Resource.fromJson(Map<String, dynamic> json) {
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