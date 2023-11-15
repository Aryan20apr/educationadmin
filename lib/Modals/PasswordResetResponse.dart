class PasswordResetResponse {
  Data? _data;

  PasswordResetResponse({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  PasswordResetResponse.fromJson(Map<String, dynamic> json) {
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
  bool? _status;

  Data({String? msg, bool? status}) {
    if (msg != null) {
      _msg = msg;
    }
    if (status != null) {
      _status = status;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  Data.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = _msg;
    data['status'] = _status;
    return data;
  }
}