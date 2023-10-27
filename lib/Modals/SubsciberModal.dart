class SubscriberListModal {
  SubcriberData? _data;

  SubscriberListModal({SubcriberData? data}) {
    if (data != null) {
      _data = data;
    }
  }

  SubcriberData? get data => _data;
  set data(SubcriberData? data) => _data = data;

  SubscriberListModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new SubcriberData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class SubcriberData {
  List<Consumers>? _consumers;
  String? _msg;

  SubcriberData({List<Consumers>? consumers, String? msg}) {
    if (consumers != null) {
      _consumers = consumers;
    }
    if (msg != null) {
      _msg = msg;
    }
  }

  List<Consumers>? get consumers => _consumers;
  set consumers(List<Consumers>? consumers) => _consumers = consumers;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  SubcriberData.fromJson(Map<String, dynamic> json) {
    if (json['consumers'] != null) {
      _consumers = <Consumers>[];
      json['consumers'].forEach((v) {
        _consumers!.add(new Consumers.fromJson(v));
      });
    }
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (_consumers != null) {
      data['consumers'] = _consumers!.map((v) => v.toJson()).toList();
    }
    data['msg'] = _msg;
    return data;
  }
}

class Consumers {
  String? _name;
  String? _phone;
  String? _email;
  String? _image;

  Consumers({String? name, String? phone, String? email, String? image}) {
    if (name != null) {
      _name = name;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (email != null) {
      _email = email;
    }
    if (image != null) {
      _image = image;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get image => _image;
  set image(String? image) => _image = image;

  Consumers.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = _name;
    data['phone'] = _phone;
    data['email'] = _email;
    data['image'] = _image;
    return data;
  }
}