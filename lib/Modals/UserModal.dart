


class UserModal {
  int? _statusCode;
  Consumer? _consumer;

  UserModal({int? statusCode, Consumer? consumer}) {
    if (statusCode != null) {
      _statusCode = statusCode;
    }
    if (consumer != null) {
      _consumer = consumer;
    }
  }

  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;
  Consumer? get consumer => _consumer;
  set consumer(Consumer? consumer) => _consumer = consumer;

  UserModal.fromJson(Map<String, dynamic> json) {
    _statusCode = json['statusCode'];
    _consumer = json['consumer'] != null
        ? new Consumer.fromJson(json['consumer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = _statusCode;
    if (_consumer != null) {
      data['consumer'] = _consumer!.toJson();
    }
    return data;
  }
}

class Consumer {

  int? _id;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  String? _phone;
  String? _email;
  String? _image;

  Consumer(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? name,
      String? phone,
      String? email,
      String? image}) {
    if (id != null) {
      _id = id;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
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

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get image => _image;
  set image(String? image) => _image = image;

  Consumer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['name'] = _name;
    data['phone'] = _phone;
    data['email'] = _email;
    data['image'] = _image;
    return data;
  }
}