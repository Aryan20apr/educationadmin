class SignupResponseModal {
  Data? _data;
  String? _msg;
  int? _statusCode;

  SignupResponseModal({Data? data, String? msg, int? statusCode}) {
    if (data != null) {
      this._data = data;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (statusCode != null) {
      this._statusCode = statusCode;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;

  SignupResponseModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _msg = json['msg'];
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['msg'] = this._msg;
    data['statusCode'] = this._statusCode;
    return data;
  }
}

class Data {
  String? _token;

  Data({String? token}) {
    if (token != null) {
      this._token = token;
    }
  }

  String? get token => _token;
  set token(String? token) => _token = token;

  Data.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    return data;
  }
}