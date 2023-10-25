class CreateChannelResponseModal {
  Data? _data;

  CreateChannelResponseModal({Data? data}) {
    if (data != null) {
      this._data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  CreateChannelResponseModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _msg;
  Channel? _channel;

  Data({String? msg, Channel? channel}) {
    if (msg != null) {
      this._msg = msg;
    }
    if (channel != null) {
      this._channel = channel;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  Channel? get channel => _channel;
  set channel(Channel? channel) => _channel = channel;

  Data.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _channel =
        json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    if (this._channel != null) {
      data['channel'] = this._channel!.toJson();
    }
    return data;
  }
}

class Channel {
  int? _id;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  bool? _isCompletelyPaid;
  String? _thumbnail;
  Null? _description;
  int? _price;
  int? _createdBy;

  Channel(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? name,
      bool? isCompletelyPaid,
      String? thumbnail,
      Null? description,
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
  Null? get description => _description;
  set description(Null? description) => _description = description;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get createdBy => _createdBy;
  set createdBy(int? createdBy) => _createdBy = createdBy;

  Channel.fromJson(Map<String, dynamic> json) {
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