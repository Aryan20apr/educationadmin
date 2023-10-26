class VideoRequestModal {
  String? _title;
  String? _link;
  String? _isPaid;
  String? _type;
  int? _channelId;

  VideoRequestModal(
      {String? title,
      String? link,
      String? isPaid,
      String? type,
      int? channelId}) {
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
    if (channelId != null) {
      _channelId = channelId;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get link => _link;
  set link(String? link) => _link = link;
  String? get isPaid => _isPaid;
  set isPaid(String? isPaid) => _isPaid = isPaid;
  String? get type => _type;
  set type(String? type) => _type = type;
  int? get channelId => _channelId;
  set channelId(int? channelId) => _channelId = channelId;

  VideoRequestModal.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _link = json['link'];
    _isPaid = json['isPaid'];
    _type = json['type'];
    _channelId = json['channelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = _title;
    data['link'] = _link;
    data['isPaid'] = _isPaid;
    data['type'] = _type;
    data['channelId'] = _channelId;
    return data;
  }
}