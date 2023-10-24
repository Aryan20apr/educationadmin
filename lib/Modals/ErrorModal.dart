class ErrorModal {
  Error? _error;
  int? _statusCode;

  ErrorModal({Error? error, int? statusCode}) {
    if (error != null) {
      this._error = error;
    }
    if (statusCode != null) {
      this._statusCode = statusCode;
    }
  }

  Error? get error => _error;
  set error(Error? error) => _error = error;
  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;

  ErrorModal.fromJson(Map<String, dynamic> json) {
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
  String? _msg;

  Error({String? msg}) {
    if (msg != null) {
      this._msg = msg;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  Error.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    return data;
  }
}