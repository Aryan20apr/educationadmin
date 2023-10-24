class PhoneModal {
  String? _number;

  PhoneModal({String? number}) {
    if (number != null) {
      this._number = number;
    }
  }

  String? get number => _number;
  set number(String? number) => _number = number;

  PhoneModal.fromJson(Map<String, dynamic> json) {
    _number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this._number;
    return data;
  }
}

class OTPModal {
  OTPData? _data;
  int? _statusCode;

  OTPModal({OTPData? data, int? statusCode}) {
    if (data != null) {
      this._data = data;
    }
    if (statusCode != null) {
      this._statusCode = statusCode;
    }
  }

  OTPData? get data => _data;
  set data(OTPData? data) => _data = data;
  int? get statusCode => _statusCode;
  set statusCode(int? statusCode) => _statusCode = statusCode;

  OTPModal.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new OTPData.fromJson(json['data']) : null;
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['statusCode'] = this._statusCode;
    return data;
  }
}

class OTPData {
  String? _otp;
  String? _msg;

  OTPData({String? otp, String? msg}) {
    if (otp != null) {
      this._otp = otp;
    }
    if (msg != null) {
      this._msg = msg;
    }
  }

  String? get otp => _otp;
  set otp(String? otp) => _otp = otp;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  OTPData.fromJson(Map<String, dynamic> json) {
    _otp = json['otp'];
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this._otp;
    data['msg'] = this._msg;
    return data;
  }
}
