
class AuthenticationExceptionModal {
  Error? error;
  int? statusCode;

  AuthenticationExceptionModal({this.error, this.statusCode});

  AuthenticationExceptionModal.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Error {
  String? code;
  String? msg;

  Error({this.code, this.msg});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}