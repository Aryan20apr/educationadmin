class SignupErrorModal {
  Error? _error;
  int? _statusCode;

  SignupErrorModal({Error? error, int? statusCode}) {
    if (error != null) {
      _error = error;
    }
    if (statusCode != null) {
      _statusCode = statusCode;
    }
  }

  Error? get error => _error;
  set error(Error? error) => _error = error;
  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;

  SignupErrorModal.fromJson(Map<String, dynamic> json) {
    _error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._error != null) {
      data['error'] = this._error!.toJson();
    }
    data['statusCode'] = this._statusCode;
    return data;
  }
}

class Error {
  String? _code;
  String? _msg;

  Error({String? code, String? msg}) {
    if (code != null) {
      this._code = code;
    }
    if (msg != null) {
      this._msg = msg;
    }
  }

  String? get code => _code;
  set code(String? code) => _code = code;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  Error.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['msg'] = this._msg;
    return data;
  }
}