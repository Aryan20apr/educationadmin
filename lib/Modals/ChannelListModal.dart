class ChannelListModal {
  Data? _data;

  ChannelListModal({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  ChannelListModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _msg;
  List<Channels>? _channels;

  Data({String? msg, List<Channels>? channels}) {
    if (msg != null) {
      this._msg = msg;
    }
    if (channels != null) {
      this._channels = channels;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Channels>? get channels => _channels;
  set channels(List<Channels>? channels) => _channels = channels;

  Data.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    if (json['channels'] != null) {
      _channels = <Channels>[];
      json['channels'].forEach((v) {
        _channels!.add(new Channels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    if (this._channels != null) {
      data['channels'] = this._channels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Channels {
  int? _id;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  bool? _isCompletelyPaid;
  String? _thumbnail;
  String? _description;
  int? _price;
  int? _createdBy;

  Channels(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? name,
      bool? isCompletelyPaid,
      String? thumbnail,
      String? description,
      int? price,
      int? createdBy}) {
    if (id != null) {
      this._id = id;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (name != null) {
      this._name = name;
    }
    if (isCompletelyPaid != null) {
      this._isCompletelyPaid = isCompletelyPaid;
    }
    if (thumbnail != null) {
      this._thumbnail = thumbnail;
    }
    if (description != null) {
      this._description = description;
    }
    if (price != null) {
      this._price = price;
    }
    if (createdBy != null) {
      this._createdBy = createdBy;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get name => _name;
  set name(String? name) => _name = name;
  bool? get isCompletelyPaid => _isCompletelyPaid;
  set isCompletelyPaid(bool? isCompletelyPaid) =>
      _isCompletelyPaid = isCompletelyPaid;
  String? get thumbnail => _thumbnail;
  set thumbnail(String? thumbnail) => _thumbnail = thumbnail;
String? get description => _description;
  set description(String? description) => _description = description;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get createdBy => _createdBy;
  set createdBy(int? createdBy) => _createdBy = createdBy;

  Channels.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _name = json['name'];
    _isCompletelyPaid = json['isCompletelyPaid'];
    _thumbnail = json['thumbnail'];
    _description = json['description'];
    _price = json['price'];
    _createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['name'] = this._name;
    data['isCompletelyPaid'] = this._isCompletelyPaid;
    data['thumbnail'] = this._thumbnail;
    data['description'] = this._description;
    data['price'] = this._price;
    data['createdBy'] = this._createdBy;
    return data;
  }
}